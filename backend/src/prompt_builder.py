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


def generate_competence_json_structure(criteria: ExamCriteria) -> str:
    """
    Gera a estrutura JSON dinamicamente baseada no número de competências.
    Vestibulares como PUCPR (4 comp) terão estrutura diferente de ENEM (5 comp).
    """
    lines = []
    for i, weight in enumerate(criteria.weights, 1):
        lines.append(f'    "competence_{i}_score": <nota de 0 a {int(weight)}>,')
    for i in range(1, len(criteria.weights) + 1):
        lines.append(f'    "competence_{i}_feedback": "📊 Análise Detalhada: <análise completa de 3-4 frases explicando a avaliação>\\n\\n✅ Pontos Fortes: <2-3 aspectos positivos específicos com citações do texto>\\n\\n⚠️ O que Melhorar: <2-3 sugestões concretas citando trechos específicos do texto que precisam de correção>\\n\\n💡 Dica Premium: <sugestão avançada para próximo nível>",')
    return "\n".join(lines)


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
    
    # Pega instruções específicas ou cria fallback genérico baseado no exam_criteria
    if exam_type in specific_instructions:
        specific_text = specific_instructions[exam_type]
    else:
        # Fallback genérico - usa os critérios do exam_criteria.py
        # Isso garante que vestibulares sem prompt específico usem sua escala correta
        specific_text = f"""
Você é um corretor do vestibular {criteria.short_name}. Analise esta redação seguindo os critérios oficiais.

**CRITÉRIOS {criteria.short_name.upper()} (total {criteria.max_score} pontos):**
ATENÇÃO: Use EXATAMENTE a escala de pontuação indicada abaixo para cada critério.
{format_competencies(criteria)}

**INSTRUÇÕES:**
- Analise cada critério individualmente
- Dê nota conforme a escala de cada critério (veja os valores máximos acima)
- Seja construtivo e específico no feedback
- Identifique pontos fortes e áreas de melhoria
"""

    
    # Monta o prompt completo
    prompt = f"""{specific_text}

**PONTUAÇÃO MÁXIMA TOTAL:** {criteria.max_score} pontos

**REDAÇÃO A SER AVALIADA:**

Título: {title or '(Sem título)'}
Tema: {theme or '(Tema livre)'}

===== CONTEÚDO =====
{content}
====================

**📝 REGRAS OBRIGATÓRIAS PARA CORREÇÃO PREMIUM:**

1. **Cada competence_X_feedback DEVE conter:**
   - 📊 Análise Detalhada: 3-4 frases explicando a avaliação
   - ✅ Pontos Fortes: 2-3 aspectos positivos específicos COM citações do texto
   - ⚠️ O que Melhorar: 2-3 sugestões concretas COM trechos específicos que precisam de correção
   - 💡 Dica Premium: 1 sugestão avançada para alcançar o próximo nível

2. **strengths DEVE ter EXATAMENTE {len(criteria.competencies)} itens** (um por competência), com frases detalhadas de 20+ palavras cada. MESMO que a redação seja fraca, encontre aspectos relativamente positivos.

3. **improvements DEVE ter EXATAMENTE {len(criteria.competencies)} itens** (um por competência), citando trechos específicos do texto entre aspas simples.

4. **general_comments DEVE ter 200+ palavras em 3 parágrafos:**
   - Parágrafo 1: Análise geral da estrutura e qualidade do texto
   - Parágrafo 2: Principais qualidades e pontos de destaque
   - Parágrafo 3: Sugestões práticas de melhoria com exemplos

5. **PROIBIDO usar:**
   - "Nenhum ponto forte identificado"
   - "N/A" ou "N/F"
   - Arrays vazios []
   - Frases genéricas sem especificidade

**RETORNE EM JSON com a seguinte estrutura EXATA (exemplo de feedback PREMIUM detalhado):**

{{
{generate_competence_json_structure(criteria)}
    "total_score": <soma de todas as competências>,
    "strengths": [
        "C1: Demonstra domínio da norma culta com vocabulário diversificado, utilizando termos como 'sustentabilidade', 'matriz energética' e 'fontes renováveis' de forma adequada ao contexto dissertativo, com poucos desvios gramaticais",
        "C2: Apresenta compreensão sólida do tema proposto, contextualizando historicamente o problema ao mencionar a dependência de combustíveis fósseis e conectando com a realidade brasileira atual de forma pertinente",
        "C3: Desenvolve argumentação consistente ao citar dados sobre energia eólica e solar, demonstrando capacidade de usar repertório sociocultural para fundamentar sua tese sobre a transição energética",
        "C4: Mantém boa progressão textual com uso variado de conectivos como 'além disso', 'contudo', 'portanto' e 'nesse contexto', garantindo fluidez entre os parágrafos e coerência argumentativa",
        "C5: Elabora proposta de intervenção com ação clara (investimento em energia limpa), agente definido (governo federal) e modo especificado (parcerias público-privadas), demonstrando entendimento da estrutura exigida"
    ],
    "improvements": [
        "C1: No trecho 'a tranzisão energética é um problema', corrigir 'tranzisão' para 'transição'. Também revisar 'pra' (coloquial) substituindo por 'para' em todo o texto",
        "C2: Aprofundar a análise do trecho 'é muito difícil' explicando POR QUE é difícil e QUAIS são os obstáculos específicos para a transição energética no Brasil",
        "C3: No parágrafo de desenvolvimento, adicionar um dado estatístico concreto (ex: 'Segundo o IBGE...') ou citação de especialista para fortalecer o argumento sobre energias renováveis",
        "C4: Substituir a repetição de 'além disso' no 3º parágrafo por conectivos variados como 'outrossim', 'ademais' ou 'sob essa perspectiva' para enriquecer a coesão",
        "C5: Completar a proposta de intervenção detalhando o EFEITO esperado (ex: 'reduzindo em 30% as emissões de carbono') e o DETALHAMENTO específico da ação proposta"
    ],
    "general_comments": "Sua redação apresenta uma estrutura dissertativo-argumentativa bem definida, com introdução que contextualiza o tema, dois parágrafos de desenvolvimento com argumentos relevantes, e conclusão que retoma a tese e apresenta proposta de intervenção. O texto demonstra maturidade intelectual e capacidade de articular ideias de forma coerente.\\n\\nEntre os pontos de destaque, sua habilidade em contextualizar historicamente o problema e conectar com a realidade atual brasileira mostra um repertório sociocultural consistente. O vocabulário utilizado é adequado ao gênero, com termos técnicos pertinentes ao tema. A progressão textual é fluida, com bom encadeamento entre os parágrafos.\\n\\nPara alcançar notas ainda mais altas, sugiro: (1) revisar erros ortográficos e de pontuação fazendo leitura em voz alta; (2) enriquecer a argumentação com dados estatísticos de fontes oficiais como IBGE ou estudos acadêmicos; (3) diversificar os conectivos evitando repetições; e (4) completar a proposta de intervenção com todos os 5 elementos exigidos - ação, agente, modo, efeito e detalhamento. Continue praticando que você está no caminho certo para alcançar excelência!"
}}

IMPORTANTE: Retorne APENAS o JSON, sem texto adicional antes ou depois.
"""
    
    return prompt
