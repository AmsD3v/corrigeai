import os
import json
import logging
import time
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
import google.generativeai as genai

# Configuração do logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# --- Configuração da API do Google Gemini ---
GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")

class MockGemini:
    """Simula a resposta do Gemini quando a chave de API não está configurada."""
    def generate_content(self, prompt):
        logger.warning("⚠️  USANDO MOCK PROVIDER: Chave da API do Google não configurada.")
        time.sleep(2) # Simula delay de processamento
        
        mock_response = {
            "competencia_1": { "nota": 120, "feedback": "[MOCK] Demonstra domínio mediano da modalidade escrita." },
            "competencia_2": { "nota": 140, "feedback": "[MOCK] Compreende a proposta, mas tangencia o tema em alguns pontos." },
            "competencia_3": { "nota": 120, "feedback": "[MOCK] Seleciona fatos, mas a organização dos argumentos é confusa." },
            "competencia_4": { "nota": 160, "feedback": "[MOCK] Articula bem as partes do texto, com poucos desvios." },
            "competencia_5": { "nota": 100, "feedback": "[MOCK] Elabora proposta de intervenção, mas falta detalhamento." },
            "nota_final": 640,
            "feedback_geral": "[MOCK] Esta é uma correção simulada pois a API Key não foi detectada. Configure GOOGLE_API_KEY no .env para usar a IA real."
        }
        
        class MockResult:
            text = json.dumps(mock_response)
            
        return MockResult()

if GOOGLE_API_KEY:
    genai.configure(api_key=GOOGLE_API_KEY)
    model = genai.GenerativeModel('gemini-pro')
    logger.info("✅ API do Google Gemini configurada com sucesso.")
else:
    logger.warning("⚠️  GOOGLE_API_KEY não encontrada. O serviço rodará em modo MOCK.")
    model = MockGemini()

# --- Modelos Pydantic para a API ---
class Submission(BaseModel):
    content: str

class CorrectionResponse(BaseModel):
    competencia_1: dict
    competencia_2: dict
    competencia_3: dict
    competencia_4: dict
    competencia_5: dict
    nota_final: int
    feedback_geral: str

# --- Inicialização da Aplicação FastAPI ---
app = FastAPI()

# --- Prompt de Correção ---
CORRECTION_PROMPT = """
Você é um corretor especialista em redações do ENEM. Analise o seguinte texto e forneça uma avaliação detalhada, seguindo estritamente a estrutura JSON abaixo. Para cada uma das 5 competências, atribua uma nota de 0 a 200 (em incrementos de 20) e forneça um feedback claro e construtivo.

Texto da Redação:
"{text}"

Formato de Saída (JSON):
{{
  "competencia_1": {{ "nota": <int>, "feedback": "<string>" }},
  "competencia_2": {{ "nota": <int>, "feedback": "<string>" }},
  "competencia_3": {{ "nota": <int>, "feedback": "<string>" }},
  "competencia_4": {{ "nota": <int>, "feedback": "<string>" }},
  "competencia_5": {{ "nota": <int>, "feedback": "<string>" }},
  "nota_final": <int_soma_total>,
  "feedback_geral": "<string_resumo>"
}}
"""

def get_correction_prompt(text: str) -> str:
    return CORRECTION_PROMPT.format(text=text)

# --- Endpoint de Correção ---
@app.post("/correct", response_model=CorrectionResponse)
async def correct_essay_with_ai(submission: Submission):
    logger.info("Recebida nova solicitação de correção.")
    
    if not submission.content:
        raise HTTPException(status_code=400, detail="O conteúdo da redação não pode estar vazio.")
        
    prompt = get_correction_prompt(submission.content)
    
    try:
        logger.info("Enviando requisição para a IA (Gemini ou Mock).")
        response = model.generate_content(prompt)
        
        # Limpa e extrai o JSON da resposta
        cleaned_response = response.text.strip()
        # Remove marcadores de código markdown se existirem
        if cleaned_response.startswith("```json"):
            cleaned_response = cleaned_response[7:]
        if cleaned_response.startswith("```"):
            cleaned_response = cleaned_response[3:]
        if cleaned_response.endswith("```"):
            cleaned_response = cleaned_response[:-3]
            
        cleaned_response = cleaned_response.strip()
        
        correction_data = json.loads(cleaned_response)
        
        logger.info("Correção processada com sucesso.")
        return correction_data
        
    except json.JSONDecodeError as e:
        logger.error(f"Erro ao decodificar o JSON da resposta da IA: {e}. Resposta crua: {response.text}")
        raise HTTPException(status_code=500, detail="A resposta da IA não pôde ser processada. Tente novamente.")
    except Exception as e:
        logger.error(f"Ocorreu um erro inesperado ao processar a correção: {e}")
        raise HTTPException(status_code=500, detail="Erro interno no serviço de correção.")

@app.get("/health")
def health_check():
    status_msg = "active" if GOOGLE_API_KEY else "mock_mode"
    return {"status": "ok", "mode": status_msg}
