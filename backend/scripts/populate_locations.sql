-- Script para popular estados e cidades brasileiras (dados IBGE)
-- Executar: docker compose exec db psql -U user -d prosaai -f /app/scripts/populate_locations.sql

-- ============================================
-- ESTADOS BRASILEIROS (27 UFs)
-- ============================================
INSERT INTO brazil_state (code, name) VALUES
('AC', 'Acre'),
('AL', 'Alagoas'),
('AP', 'Amapá'),
('AM', 'Amazonas'),
('BA', 'Bahia'),
('CE', 'Ceará'),
('DF', 'Distrito Federal'),
('ES', 'Espírito Santo'),
('GO', 'Goiás'),
('MA', 'Maranhão'),
('MT', 'Mato Grosso'),
('MS', 'Mato Grosso do Sul'),
('MG', 'Minas Gerais'),
('PA', 'Pará'),
('PB', 'Paraíba'),
('PR', 'Paraná'),
('PE', 'Pernambuco'),
('PI', 'Piauí'),
('RJ', 'Rio de Janeiro'),
('RN', 'Rio Grande do Norte'),
('RS', 'Rio Grande do Sul'),
('RO', 'Rondônia'),
('RR', 'Roraima'),
('SC', 'Santa Catarina'),
('SP', 'São Paulo'),
('SE', 'Sergipe'),
('TO', 'Tocantins')
ON CONFLICT (code) DO NOTHING;

-- ============================================
-- CIDADES BRASILEIRAS (Principais por estado)
-- ============================================

-- ACRE (AC)
INSERT INTO brazil_city (name, state_code) VALUES
('Rio Branco', 'AC'),
('Cruzeiro do Sul', 'AC'),
('Sena Madureira', 'AC'),
('Tarauacá', 'AC'),
('Feijó', 'AC'),
('Brasiléia', 'AC'),
('Senador Guiomard', 'AC'),
('Plácido de Castro', 'AC'),
('Xapuri', 'AC'),
('Epitaciolândia', 'AC');

-- ALAGOAS (AL)
INSERT INTO brazil_city (name, state_code) VALUES
('Maceió', 'AL'),
('Arapiraca', 'AL'),
('Rio Largo', 'AL'),
('Palmeira dos Índios', 'AL'),
('União dos Palmares', 'AL'),
('Penedo', 'AL'),
('São Miguel dos Campos', 'AL'),
('Santana do Ipanema', 'AL'),
('Delmiro Gouveia', 'AL'),
('Coruripe', 'AL');

-- AMAPÁ (AP)
INSERT INTO brazil_city (name, state_code) VALUES
('Macapá', 'AP'),
('Santana', 'AP'),
('Laranjal do Jari', 'AP'),
('Oiapoque', 'AP'),
('Mazagão', 'AP'),
('Porto Grande', 'AP'),
('Tartarugalzinho', 'AP'),
('Pedra Branca do Amapari', 'AP'),
('Vitória do Jari', 'AP'),
('Calçoene', 'AP');

-- AMAZONAS (AM)
INSERT INTO brazil_city (name, state_code) VALUES
('Manaus', 'AM'),
('Parintins', 'AM'),
('Itacoatiara', 'AM'),
('Manacapuru', 'AM'),
('Coari', 'AM'),
('Tefé', 'AM'),
('Tabatinga', 'AM'),
('Maués', 'AM'),
('Iranduba', 'AM'),
('Presidente Figueiredo', 'AM');

-- BAHIA (BA)
INSERT INTO brazil_city (name, state_code) VALUES
('Salvador', 'BA'),
('Feira de Santana', 'BA'),
('Vitória da Conquista', 'BA'),
('Camaçari', 'BA'),
('Itabuna', 'BA'),
('Juazeiro', 'BA'),
('Lauro de Freitas', 'BA'),
('Ilhéus', 'BA'),
('Jequié', 'BA'),
('Teixeira de Freitas', 'BA'),
('Barreiras', 'BA'),
('Alagoinhas', 'BA'),
('Porto Seguro', 'BA'),
('Simões Filho', 'BA'),
('Paulo Afonso', 'BA');

-- CEARÁ (CE)
INSERT INTO brazil_city (name, state_code) VALUES
('Fortaleza', 'CE'),
('Caucaia', 'CE'),
('Juazeiro do Norte', 'CE'),
('Maracanaú', 'CE'),
('Sobral', 'CE'),
('Crato', 'CE'),
('Itapipoca', 'CE'),
('Maranguape', 'CE'),
('Iguatu', 'CE'),
('Quixadá', 'CE'),
('Pacatuba', 'CE'),
('Aquiraz', 'CE'),
('Russas', 'CE'),
('Canindé', 'CE'),
('Tianguá', 'CE');

-- DISTRITO FEDERAL (DF)
INSERT INTO brazil_city (name, state_code) VALUES
('Brasília', 'DF'),
('Ceilândia', 'DF'),
('Taguatinga', 'DF'),
('Samambaia', 'DF'),
('Planaltina', 'DF'),
('Águas Claras', 'DF'),
('Gama', 'DF'),
('Guará', 'DF'),
('Santa Maria', 'DF'),
('Sobradinho', 'DF');

-- ESPÍRITO SANTO (ES)
INSERT INTO brazil_city (name, state_code) VALUES
('Vitória', 'ES'),
('Vila Velha', 'ES'),
('Serra', 'ES'),
('Cariacica', 'ES'),
('Linhares', 'ES'),
('Cachoeiro de Itapemirim', 'ES'),
('Colatina', 'ES'),
('Guarapari', 'ES'),
('São Mateus', 'ES'),
('Aracruz', 'ES'),
('Viana', 'ES'),
('Nova Venécia', 'ES'),
('Barra de São Francisco', 'ES'),
('Marataízes', 'ES'),
('Fundão', 'ES');

-- GOIÁS (GO)
INSERT INTO brazil_city (name, state_code) VALUES
('Goiânia', 'GO'),
('Aparecida de Goiânia', 'GO'),
('Anápolis', 'GO'),
('Rio Verde', 'GO'),
('Luziânia', 'GO'),
('Águas Lindas de Goiás', 'GO'),
('Valparaíso de Goiás', 'GO'),
('Trindade', 'GO'),
('Formosa', 'GO'),
('Novo Gama', 'GO'),
('Itumbiara', 'GO'),
('Senador Canedo', 'GO'),
('Catalão', 'GO'),
('Jataí', 'GO'),
('Planaltina', 'GO');

-- MARANHÃO (MA)
INSERT INTO brazil_city (name, state_code) VALUES
('São Luís', 'MA'),
('Imperatriz', 'MA'),
('São José de Ribamar', 'MA'),
('Timon', 'MA'),
('Caxias', 'MA'),
('Codó', 'MA'),
('Paço do Lumiar', 'MA'),
('Açailândia', 'MA'),
('Bacabal', 'MA'),
('Balsas', 'MA'),
('Santa Inês', 'MA'),
('Barra do Corda', 'MA'),
('Pinheiro', 'MA'),
('Chapadinha', 'MA'),
('Buriticupu', 'MA');

-- MATO GROSSO (MT)
INSERT INTO brazil_city (name, state_code) VALUES
('Cuiabá', 'MT'),
('Várzea Grande', 'MT'),
('Rondonópolis', 'MT'),
('Sinop', 'MT'),
('Tangará da Serra', 'MT'),
('Cáceres', 'MT'),
('Sorriso', 'MT'),
('Lucas do Rio Verde', 'MT'),
('Primavera do Leste', 'MT'),
('Barra do Garças', 'MT'),
('Alta Floresta', 'MT'),
('Pontes e Lacerda', 'MT'),
('Juína', 'MT'),
('Campo Verde', 'MT'),
('Nova Mutum', 'MT');

-- MATO GROSSO DO SUL (MS)
INSERT INTO brazil_city (name, state_code) VALUES
('Campo Grande', 'MS'),
('Dourados', 'MS'),
('Três Lagoas', 'MS'),
('Corumbá', 'MS'),
('Ponta Porã', 'MS'),
('Naviraí', 'MS'),
('Nova Andradina', 'MS'),
('Aquidauana', 'MS'),
('Sidrolândia', 'MS'),
('Paranaíba', 'MS'),
('Maracaju', 'MS'),
('Amambai', 'MS'),
('Coxim', 'MS'),
('Rio Brilhante', 'MS'),
('Chapadão do Sul', 'MS');

-- MINAS GERAIS (MG)
INSERT INTO brazil_city (name, state_code) VALUES
('Belo Horizonte', 'MG'),
('Uberlândia', 'MG'),
('Contagem', 'MG'),
('Juiz de Fora', 'MG'),
('Betim', 'MG'),
('Montes Claros', 'MG'),
('Ribeirão das Neves', 'MG'),
('Uberaba', 'MG'),
('Governador Valadares', 'MG'),
('Ipatinga', 'MG'),
('Sete Lagoas', 'MG'),
('Divinópolis', 'MG'),
('Santa Luzia', 'MG'),
('Poços de Caldas', 'MG'),
('Patos de Minas', 'MG'),
('Pouso Alegre', 'MG'),
('Teófilo Otoni', 'MG'),
('Barbacena', 'MG'),
('Sabará', 'MG'),
('Varginha', 'MG');

-- PARÁ (PA)
INSERT INTO brazil_city (name, state_code) VALUES
('Belém', 'PA'),
('Ananindeua', 'PA'),
('Santarém', 'PA'),
('Marabá', 'PA'),
('Parauapebas', 'PA'),
('Castanhal', 'PA'),
('Abaetetuba', 'PA'),
('Cametá', 'PA'),
('Marituba', 'PA'),
('Bragança', 'PA'),
('Altamira', 'PA'),
('Barcarena', 'PA'),
('Tucuruí', 'PA'),
('Itaituba', 'PA'),
('Paragominas', 'PA');

-- PARAÍBA (PB)
INSERT INTO brazil_city (name, state_code) VALUES
('João Pessoa', 'PB'),
('Campina Grande', 'PB'),
('Santa Rita', 'PB'),
('Patos', 'PB'),
('Bayeux', 'PB'),
('Sousa', 'PB'),
('Cabedelo', 'PB'),
('Cajazeiras', 'PB'),
('Guarabira', 'PB'),
('Sapé', 'PB'),
('Mamanguape', 'PB'),
('Monteiro', 'PB'),
('Pombal', 'PB'),
('Queimadas', 'PB'),
('Conde', 'PB');

-- PARANÁ (PR)
INSERT INTO brazil_city (name, state_code) VALUES
('Curitiba', 'PR'),
('Londrina', 'PR'),
('Maringá', 'PR'),
('Ponta Grossa', 'PR'),
('Cascavel', 'PR'),
('São José dos Pinhais', 'PR'),
('Foz do Iguaçu', 'PR'),
('Colombo', 'PR'),
('Guarapuava', 'PR'),
('Paranaguá', 'PR'),
('Araucária', 'PR'),
('Toledo', 'PR'),
('Apucarana', 'PR'),
('Pinhais', 'PR'),
('Campo Largo', 'PR'),
('Almirante Tamandaré', 'PR'),
('Umuarama', 'PR'),
('Cambé', 'PR'),
('Arapongas', 'PR'),
('Piraquara', 'PR');

-- PERNAMBUCO (PE)
INSERT INTO brazil_city (name, state_code) VALUES
('Recife', 'PE'),
('Jaboatão dos Guararapes', 'PE'),
('Olinda', 'PE'),
('Caruaru', 'PE'),
('Petrolina', 'PE'),
('Paulista', 'PE'),
('Cabo de Santo Agostinho', 'PE'),
('Camaragibe', 'PE'),
('Garanhuns', 'PE'),
('Vitória de Santo Antão', 'PE'),
('Igarassu', 'PE'),
('São Lourenço da Mata', 'PE'),
('Abreu e Lima', 'PE'),
('Serra Talhada', 'PE'),
('Araripina', 'PE');

-- PIAUÍ (PI)
INSERT INTO brazil_city (name, state_code) VALUES
('Teresina', 'PI'),
('Parnaíba', 'PI'),
('Picos', 'PI'),
('Piripiri', 'PI'),
('Floriano', 'PI'),
('Campo Maior', 'PI'),
('Barras', 'PI'),
('União', 'PI'),
('Altos', 'PI'),
('José de Freitas', 'PI'),
('Pedro II', 'PI'),
('Oeiras', 'PI'),
('Esperantina', 'PI'),
('Luís Correia', 'PI'),
('Bom Jesus', 'PI');

-- RIO DE JANEIRO (RJ)
INSERT INTO brazil_city (name, state_code) VALUES
('Rio de Janeiro', 'RJ'),
('São Gonçalo', 'RJ'),
('Duque de Caxias', 'RJ'),
('Nova Iguaçu', 'RJ'),
('Niterói', 'RJ'),
('Belford Roxo', 'RJ'),
('São João de Meriti', 'RJ'),
('Campos dos Goytacazes', 'RJ'),
('Petrópolis', 'RJ'),
('Volta Redonda', 'RJ'),
('Magé', 'RJ'),
('Itaboraí', 'RJ'),
('Macaé', 'RJ'),
('Mesquita', 'RJ'),
('Nova Friburgo', 'RJ'),
('Barra Mansa', 'RJ'),
('Angra dos Reis', 'RJ'),
('Cabo Frio', 'RJ'),
('Teresópolis', 'RJ'),
('Nilópolis', 'RJ');

-- RIO GRANDE DO NORTE (RN)
INSERT INTO brazil_city (name, state_code) VALUES
('Natal', 'RN'),
('Mossoró', 'RN'),
('Parnamirim', 'RN'),
('São Gonçalo do Amarante', 'RN'),
('Macaíba', 'RN'),
('Ceará-Mirim', 'RN'),
('Caicó', 'RN'),
('Açu', 'RN'),
('Currais Novos', 'RN'),
('São José de Mipibu', 'RN'),
('Santa Cruz', 'RN'),
('Apodi', 'RN'),
('João Câmara', 'RN'),
('Nova Cruz', 'RN'),
('Extremoz', 'RN');

-- RIO GRANDE DO SUL (RS)
INSERT INTO brazil_city (name, state_code) VALUES
('Porto Alegre', 'RS'),
('Caxias do Sul', 'RS'),
('Canoas', 'RS'),
('Pelotas', 'RS'),
('Santa Maria', 'RS'),
('Gravataí', 'RS'),
('Viamão', 'RS'),
('Novo Hamburgo', 'RS'),
('São Leopoldo', 'RS'),
('Rio Grande', 'RS'),
('Alvorada', 'RS'),
('Passo Fundo', 'RS'),
('Sapucaia do Sul', 'RS'),
('Uruguaiana', 'RS'),
('Santa Cruz do Sul', 'RS'),
('Cachoeirinha', 'RS'),
('Bagé', 'RS'),
('Bento Gonçalves', 'RS'),
('Erechim', 'RS'),
('Guaíba', 'RS');

-- RONDÔNIA (RO)
INSERT INTO brazil_city (name, state_code) VALUES
('Porto Velho', 'RO'),
('Ji-Paraná', 'RO'),
('Ariquemes', 'RO'),
('Vilhena', 'RO'),
('Cacoal', 'RO'),
('Rolim de Moura', 'RO'),
('Jaru', 'RO'),
('Guajará-Mirim', 'RO'),
('Ouro Preto do Oeste', 'RO'),
('Pimenta Bueno', 'RO');

-- RORAIMA (RR)
INSERT INTO brazil_city (name, state_code) VALUES
('Boa Vista', 'RR'),
('Rorainópolis', 'RR'),
('Caracaraí', 'RR'),
('Alto Alegre', 'RR'),
('Mucajaí', 'RR'),
('Cantá', 'RR'),
('Pacaraima', 'RR'),
('Bonfim', 'RR'),
('São João da Baliza', 'RR'),
('São Luiz', 'RR');

-- SANTA CATARINA (SC)
INSERT INTO brazil_city (name, state_code) VALUES
('Joinville', 'SC'),
('Florianópolis', 'SC'),
('Blumenau', 'SC'),
('São José', 'SC'),
('Chapecó', 'SC'),
('Itajaí', 'SC'),
('Criciúma', 'SC'),
('Jaraguá do Sul', 'SC'),
('Lages', 'SC'),
('Palhoça', 'SC'),
('Balneário Camboriú', 'SC'),
('Brusque', 'SC'),
('Tubarão', 'SC'),
('São Bento do Sul', 'SC'),
('Caçador', 'SC'),
('Concórdia', 'SC'),
('Camboriú', 'SC'),
('Navegantes', 'SC'),
('Gaspar', 'SC'),
('Rio do Sul', 'SC');

-- SÃO PAULO (SP)
INSERT INTO brazil_city (name, state_code) VALUES
('São Paulo', 'SP'),
('Guarulhos', 'SP'),
('Campinas', 'SP'),
('São Bernardo do Campo', 'SP'),
('Santo André', 'SP'),
('São José dos Campos', 'SP'),
('Osasco', 'SP'),
('Ribeirão Preto', 'SP'),
('Sorocaba', 'SP'),
('Mauá', 'SP'),
('São José do Rio Preto', 'SP'),
('Santos', 'SP'),
('Mogi das Cruzes', 'SP'),
('Diadema', 'SP'),
('Jundiaí', 'SP'),
('Piracicaba', 'SP'),
('Carapicuíba', 'SP'),
('Bauru', 'SP'),
('Itaquaquecetuba', 'SP'),
('São Vicente', 'SP'),
('Franca', 'SP'),
('Praia Grande', 'SP'),
('Guarujá', 'SP'),
('Taubaté', 'SP'),
('Limeira', 'SP'),
('Suzano', 'SP'),
('Taboão da Serra', 'SP'),
('Sumaré', 'SP'),
('Barueri', 'SP'),
('Embu das Artes', 'SP');

-- SERGIPE (SE)
INSERT INTO brazil_city (name, state_code) VALUES
('Aracaju', 'SE'),
('Nossa Senhora do Socorro', 'SE'),
('Lagarto', 'SE'),
('Itabaiana', 'SE'),
('São Cristóvão', 'SE'),
('Estância', 'SE'),
('Tobias Barreto', 'SE'),
('Itabaianinha', 'SE'),
('Simão Dias', 'SE'),
('Capela', 'SE'),
('Propriá', 'SE'),
('Barra dos Coqueiros', 'SE'),
('Nossa Senhora da Glória', 'SE'),
('Canindé de São Francisco', 'SE'),
('Poço Redondo', 'SE');

-- TOCANTINS (TO)
INSERT INTO brazil_city (name, state_code) VALUES
('Palmas', 'TO'),
('Araguaína', 'TO'),
('Gurupi', 'TO'),
('Porto Nacional', 'TO'),
('Paraíso do Tocantins', 'TO'),
('Colinas do Tocantins', 'TO'),
('Guaraí', 'TO'),
('Tocantinópolis', 'TO'),
('Dianópolis', 'TO'),
('Miracema do Tocantins', 'TO'),
('Formoso do Araguaia', 'TO'),
('Augustinópolis', 'TO'),
('Pedro Afonso', 'TO'),
('Araguatins', 'TO'),
('Taguatinga', 'TO');

-- Verificar contagem
SELECT 'Estados: ' || COUNT(*) FROM brazil_state;
SELECT 'Cidades: ' || COUNT(*) FROM brazil_city;
