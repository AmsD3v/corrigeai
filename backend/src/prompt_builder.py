"""
Gerador de prompts específicos para cada tipo de vestibular/concurso.
Cada vestibular tem critérios únicos que devem ser refletidos no prompt da IA.
"""

from .exam_criteria import get_exam_criteria, ExamCriteria


def format_competencies(criteria: ExamCriteria) -> str:
    """Formata as competências de forma legível para o prompt"""
    formatted = []
    for i, comp in enumerate(criteria.competencies, 1):
        weight = criteria.weights[i-1]
        formatted.append(f"{i}. {comp} (0-{int(weight)} pontos)")
    return "\n".join(formatted)


def create_correction_prompt(exam_type: str, title: str, theme: str, content: str) -> str:
    """
    Cria um prompt específico para correção baseado no tipo de exame.
    
    Args:
        exam_type: Tipo de exame (enem, fuvest, unicamp, etc.)
        title: Título da redação
        theme: Tema da redação
        content: Conteúdo da redação
    
    Returns:
        Prompt formatado para a IA
    """
    criteria = get_exam_criteria(exam_type)
    
    # Prompts específicos por vestibular
    specific_instructions = {
        'enem': f"""
Você é um corretor OFICIAL do ENEM. Analise esta redação seguindo RIGOROSAMENTE as 5 competências oficiais.

**CRITÉRIOS ENEM (0-200 pontos cada):**
IMPORTANTE: A nota de cada competência varia de 0 a 200.
Notas comuns: 40 (precário), 80 (insuficiente), 120 (médio), 160 (bom), 200 (excelente).
NUNCA dê notas como 5, 10 ou 20 se a redação for razoável. Use a escala de 0 a 200.

{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS ENEM:**
- Competência 5 (Proposta de Intervenção) é OBRIGATÓRIA e deve conter:
  * AÇÃO detalhada (o quê fazer)
  * AGENTE (quem vai fazer)
  * MODO/MEIO (como fazer)
  * EFEITO (resultado esperado)
  * DETALHAMENTO (especificidade da proposta)
- Respeito aos Direitos Humanos é OBRIGATÓRIO (desrespeito = nota ZERO)
- Tipo textual: Dissertativo-argumentativo
- Mínimo de 3 argumentos bem desenvolvidos
- Repertório sociocultural legitimado é diferencial
        """,
        
        'fuvest': f"""
Você é um corretor OFICIAL da FUVEST (USP). Analise esta redação seguindo os 4 critérios oficiais.

**CRITÉRIOS FUVEST (0-12.5 pontos cada, total 50):**
IMPORTANTE: A FUVEST valoriza a capacidade crítica e a fuga do senso comum.
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS FUVEST:**
- TÍTULO é OBRIGATÓRIO e deve ser criativo.
- Foco em DESENVOLVIMENTO TEMÁTICO aprofundado e autoral.
- Linguagem formal, vocabulário rico e precisão vocabular são essenciais.
- ESTRUTURA: Introdução, desenvolvimento e conclusão bem marcados.
- Argumentação deve ser CRIATIVA e AUTORAL (fuga do senso comum e de modelos prontos/caveirões).
- Repertório cultural amplo (filosofia, sociologia, literatura) é muito valorizado.
- Não exige proposta de intervenção (diferente do ENEM). Conclusão pode ser síntese ou reflexão.
        """,
        
        'unicamp': f"""
Você é um corretor OFICIAL da UNICAMP. Analise esta redação considerando o GÊNERO TEXTUAL proposto.

**CRITÉRIOS UNICAMP (0-9.6 pontos cada, total 48):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS UNICAMP:**
- O GÊNERO TEXTUAL é o aspecto mais importante (carta, artigo, discurso, etc.).
- Se o candidato não atender ao gênero, a nota cai drasticamente.
- INTERLOCUÇÃO: O texto deve dialogar com o público-alvo definido na proposta.
- MÁSCARA: O candidato deve assumir a "persona" pedida (ex: "você é um estudante...", "você é um cientista...").
- Título: Depende do gênero (Carta não tem título, Artigo tem).
- Pode e deve usar 1ª pessoa se o gênero pedir.
- Leitura da coletânea é obrigatória para contextualizar, mas sem cópia.
        """,
        
        'ita': f"""
Você é um corretor OFICIAL do ITA (Instituto Tecnológico de Aeronáutica). Analise esta redação com RIGOR CIENTÍFICO e LÓGICO.

**CRITÉRIOS ITA (0-20 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS ITA:**
- RIGOR LÓGICO e CIENTÍFICO são essenciais. Falácias lógicas penalizam muito.
- Argumentação deve ser TÉCNICA, BEM FUNDAMENTADA e OBJETIVA.
- Evitar sentimentalismo, clichês e "floreios" desnecessários.
- Clareza e precisão na exposição de ideias (estilo direto).
        """,
        
        'sisu': f"""
Você é um corretor do SISU (usa critérios do ENEM). Analise esta redação seguindo as 5 competências do ENEM.

**CRITÉRIOS SISU/ENEM (0-200 pontos cada, total 1000):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS SISU:**
(Mesmas do ENEM - Proposta de intervenção obrigatória, respeito aos direitos humanos, etc.)
        """
    }
    
    # Pega instruções específicas ou usa ENEM como fallback
    specific_text = specific_instructions.get(exam_type, specific_instructions['enem'])
    
    # Monta o prompt completo
    prompt = f"""{specific_text}

**PONTUAÇÃO MÁXIMA TOTAL:** {criteria.max_score} pontos

**REDAÇÃO A SER AVALIADA:**

Título: {title or '(Sem título)'}
Tema: {theme or '(Tema livre)'}

===== CONTEÚDO =====
{content}
====================

**RETORNE EM JSON com a seguinte estrutura EXATA:**

{{
    "competence_1_score": <nota de 0 a {int(criteria.weights[0])}>,
    "competence_2_score": <nota de 0 a {int(criteria.weights[1])}>,
    "competence_3_score": <nota de 0 a {int(criteria.weights[2]) if len(criteria.weights) > 2 else 0}>,
    "competence_4_score": <nota de 0 a {int(criteria.weights[3]) if len(criteria.weights) > 3 else 0}>,
    "competence_5_score": <nota de 0 a {int(criteria.weights[4]) if len(criteria.weights) > 4 else 0}>,
    "total_score": <soma de todas as competências>,
    "competence_1_feedback": "<feedback detalhado da competência 1>",
    "competence_2_feedback": "<feedback detalhado da competência 2>",
    "competence_3_feedback": "<feedback detalhado da competência 3>",
    "competence_4_feedback": "<feedback detalhado da competência 4>",
    "competence_5_feedback": "<feedback detalhado da competência 5>",
    "strengths": "<lista de pontos fortes em JSON array>",
    "improvements": "<lista de pontos a melhorar em JSON array>",
    "general_comments": "<comentário geral sobre a redação>"
}}

IMPORTANTE: Retorne APENAS o JSON, sem texto adicional antes ou depois.
"""
    
    return prompt
