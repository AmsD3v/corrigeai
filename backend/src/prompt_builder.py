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
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS FUVEST:**
- Foco em DESENVOLVIMENTO TEMÁTICO aprofundado
- Linguagem formal e vocabulário rico são essenciais
- ESTRUTURA clara: introdução, desenvolvimento, conclusão
- Argumentação deve ser CRIATIVA e AUTORAL (fuga do senso comum)
- Repertório cultural amplo é muito valorizado
- Estilo de escrita sofisticado faz diferença
- Não exige proposta de intervenção (diferente do ENEM)
        """,
        
        'unicamp': f"""
Você é um corretor OFICIAL da UNICAMP. Analise esta redação considerando o GÊNERO TEXTUAL proposto.

**CRITÉRIOS UNICAMP (0-9.6 pontos cada, total 48):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS UNICAMP:**
- GÊNERO TEXTUAL é fundamental (carta, artigo, relato, manifesto, etc.)
- Adequação ao PROPÓSITO COMUNICATIVO do gênero
- Interlocutor e contexto devem ser considerados
- Pode exigir 1ª pessoa (diferente de ENEM/FUVEST)
- Marcas do gênero devem estar presentes
- Criatividade dentro do gênero é valorizada
        """,
        
        'ita': f"""
Você é um corretor OFICIAL do ITA (Instituto Tecnológico de Aeronáutica). Analise esta redação com RIGOR CIENTÍFICO.

**CRITÉRIOS ITA (0-20 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS ITA:**
- RIGOR LÓGICO e CIENTÍFICO são essenciais
- Argumentação deve ser TÉCNICA e BEM FUNDAMENTADA
- Conhecimento técnico-científico é ALTAMENTE valorizado
- Clareza e precisão na exposição de ideias
- Evitar generalizações e achismos
- Dados, estatísticas e referências científicas são diferenciais
- Linguagem formal e objetiva
        """,
        
        'unesp': f"""
Você é um corretor OFICIAL da UNESP. Analise esta redação valorizando AUTORIA e REPERTÓRIO CULTURAL.

**CRITÉRIOS UNESP (0-20 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS UNESP:**
- AUTORIA e ORIGINALIDADE são muito valorizadas
- Posicionamento CRÍTICO e CRIATIVO
- REPERTÓRIO CULTURAL amplo é diferencial
- Conhecimento de mundo demonstrado
- Fuga do senso comum
- Articulação de ideias de forma pessoal
        """,
        
        'uerj': f"""
Você é um corretor OFICIAL da UERJ. Analise esta redação nos 3 aspectos fundamentais.

**CRITÉRIOS UERJ (aproximadamente 33 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS UERJ:**
- Adequação ao TEMA e ao GÊNERO textual
- Articulação textual: coesão, coerência, progressão
- Domínio da língua padrão: gramática impecável
- Menos competências, mas avaliação mais abrangente em cada uma
        """,
        
        'ufmg': f"""
Você é um corretor OFICIAL da UFMG. Analise esta redação com equilíbrio entre tema, argumentação e linguagem.

**CRITÉRIOS UFMG (0-25 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS UFMG:**
- Equilíbrio entre ABORDAGEM DO TEMA e ARGUMENTAÇÃO
- Uso de INFORMAÇÕES relevantes e atualizadas
- Articulação argumentativa consistente
- Domínio da norma culta
        """,
        
        'afa': f"""
Você é um corretor OFICIAL da AFA (Academia da Força Aérea). Analise esta redação com padrões MILITARES.

**CRITÉRIOS AFA (0-20 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS AFA:**
- CLAREZA e OBJETIVIDADE são fundamentais (padrão militar)
- Argumentação LÓGICA e BEM ESTRUTURADA
- Coerência e coesão impecáveis
- Linguagem formal e precisa
- Evitar prolixidade (ser direto ao ponto)
- Organização textual clara
        """,
        
        'cacd': f"""
Você é um corretor do CONCURSO MAIS DIFÍCIL DO BRASIL - Carreira Diplomática (CACD/Instituto Rio Branco).
Esta é uma correção de ALTÍSSIMO NÍVEL. Seja EXTREMAMENTE RIGOROSO.

**CRITÉRIOS CACD (0-20 pontos cada, total 100):**
{format_competencies(criteria)}

**INSTRUÇÕES ESPECÍFICAS CACD:**
- Este é o CONCURSO MAIS DIFÍCIL do Brasil - exija EXCELÊNCIA
- Repertório sociocultural deve ser EXCEPCIONAL e MULTIDISCIPLINAR
- Perspectiva GEOPOLÍTICA e INTERNACIONAL é OBRIGATÓRIA
- Linguagem deve ser EXTREMAMENTE FORMAL e SOFISTICADA
- Argumentação deve ser ANALÍTICA, PROFUNDA e NUANÇADA
- Conhecimento de história, filosofia, relações internacionais é esperado
- Articulação de ideias COMPLEXAS com clareza absoluta
- Vocabulário amplo e preciso (nível superior de escrita)
- Contexto mundial e brasileiro devem ser articulados
- SEJA RIGOROSO: notas altas só para textos verdadeiramente excepcionais
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
    "competence_3_score": <nota de 0 a {int(criteria.weights[2]if len(criteria.weights) > 2 else 0)}>,
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
