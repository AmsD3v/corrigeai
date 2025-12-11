-- Criar tabelas de estados e cidades do Brasil
-- e popular com todos os dados

-- Criar tabela de estados
CREATE TABLE IF NOT EXISTS brazil_state (
    id SERIAL PRIMARY KEY,
    code VARCHAR(2) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL
);

-- Criar tabela de cidades
CREATE TABLE IF NOT EXISTS brazil_city (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    state_code VARCHAR(2) NOT NULL REFERENCES brazil_state(code)
);

-- Limpar dados existentes
DELETE FROM brazil_city;
DELETE FROM brazil_state;

-- Inserir todos os 27 estados brasileiros
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
('TO', 'Tocantins');

-- Inserir principais cidades de cada estado (cidades mais populosas)
-- AC - Acre
INSERT INTO brazil_city (name, state_code) VALUES
('Rio Branco', 'AC'), ('Cruzeiro do Sul', 'AC'), ('Sena Madureira', 'AC'), ('Tarauacá', 'AC'), ('Feijó', 'AC'),
('Brasiléia', 'AC'), ('Epitaciolândia', 'AC'), ('Xapuri', 'AC'), ('Plácido de Castro', 'AC'), ('Senador Guiomard', 'AC');

-- AL - Alagoas
INSERT INTO brazil_city (name, state_code) VALUES
('Maceió', 'AL'), ('Arapiraca', 'AL'), ('Rio Largo', 'AL'), ('Palmeira dos Índios', 'AL'), ('União dos Palmares', 'AL'),
('Penedo', 'AL'), ('São Miguel dos Campos', 'AL'), ('Delmiro Gouveia', 'AL'), ('Campo Alegre', 'AL'), ('Coruripe', 'AL');

-- AP - Amapá
INSERT INTO brazil_city (name, state_code) VALUES
('Macapá', 'AP'), ('Santana', 'AP'), ('Laranjal do Jari', 'AP'), ('Oiapoque', 'AP'), ('Mazagão', 'AP'),
('Porto Grande', 'AP'), ('Pedra Branca do Amapari', 'AP'), ('Tartarugalzinho', 'AP'), ('Vitória do Jari', 'AP'), ('Calçoene', 'AP');

-- AM - Amazonas
INSERT INTO brazil_city (name, state_code) VALUES
('Manaus', 'AM'), ('Parintins', 'AM'), ('Itacoatiara', 'AM'), ('Manacapuru', 'AM'), ('Coari', 'AM'),
('Tefé', 'AM'), ('Tabatinga', 'AM'), ('Maués', 'AM'), ('São Gabriel da Cachoeira', 'AM'), ('Humaitá', 'AM'),
('Manicoré', 'AM'), ('Iranduba', 'AM'), ('Autazes', 'AM'), ('Careiro Castanho', 'AM'), ('Presidente Figueiredo', 'AM');

-- BA - Bahia
INSERT INTO brazil_city (name, state_code) VALUES
('Salvador', 'BA'), ('Feira de Santana', 'BA'), ('Vitória da Conquista', 'BA'), ('Camaçari', 'BA'), ('Itabuna', 'BA'),
('Juazeiro', 'BA'), ('Lauro de Freitas', 'BA'), ('Ilhéus', 'BA'), ('Jequié', 'BA'), ('Teixeira de Freitas', 'BA'),
('Alagoinhas', 'BA'), ('Barreiras', 'BA'), ('Porto Seguro', 'BA'), ('Simões Filho', 'BA'), ('Paulo Afonso', 'BA'),
('Eunápolis', 'BA'), ('Santo Antônio de Jesus', 'BA'), ('Valença', 'BA'), ('Candeias', 'BA'), ('Guanambi', 'BA');

-- CE - Ceará
INSERT INTO brazil_city (name, state_code) VALUES
('Fortaleza', 'CE'), ('Caucaia', 'CE'), ('Juazeiro do Norte', 'CE'), ('Maracanaú', 'CE'), ('Sobral', 'CE'),
('Crato', 'CE'), ('Itapipoca', 'CE'), ('Maranguape', 'CE'), ('Iguatu', 'CE'), ('Quixadá', 'CE'),
('Pacatuba', 'CE'), ('Aquiraz', 'CE'), ('Crateús', 'CE'), ('Canindé', 'CE'), ('Russas', 'CE'),
('Tianguá', 'CE'), ('Pacajus', 'CE'), ('Aracati', 'CE'), ('Horizonte', 'CE'), ('Limoeiro do Norte', 'CE');

-- DF - Distrito Federal
INSERT INTO brazil_city (name, state_code) VALUES
('Brasília', 'DF'), ('Ceilândia', 'DF'), ('Taguatinga', 'DF'), ('Samambaia', 'DF'), ('Planaltina', 'DF'),
('Águas Claras', 'DF'), ('Gama', 'DF'), ('Guará', 'DF'), ('Recanto das Emas', 'DF'), ('Sobradinho', 'DF');

-- ES - Espírito Santo
INSERT INTO brazil_city (name, state_code) VALUES
('Vitória', 'ES'), ('Vila Velha', 'ES'), ('Serra', 'ES'), ('Cariacica', 'ES'), ('Cachoeiro de Itapemirim', 'ES'),
('Linhares', 'ES'), ('São Mateus', 'ES'), ('Colatina', 'ES'), ('Guarapari', 'ES'), ('Aracruz', 'ES'),
('Viana', 'ES'), ('Nova Venécia', 'ES'), ('Barra de São Francisco', 'ES'), ('Santa Maria de Jetibá', 'ES'), ('Marataízes', 'ES');

-- GO - Goiás
INSERT INTO brazil_city (name, state_code) VALUES
('Goiânia', 'GO'), ('Aparecida de Goiânia', 'GO'), ('Anápolis', 'GO'), ('Rio Verde', 'GO'), ('Luziânia', 'GO'),
('Águas Lindas de Goiás', 'GO'), ('Valparaíso de Goiás', 'GO'), ('Trindade', 'GO'), ('Formosa', 'GO'), ('Novo Gama', 'GO'),
('Senador Canedo', 'GO'), ('Itumbiara', 'GO'), ('Jataí', 'GO'), ('Catalão', 'GO'), ('Planaltina', 'GO'),
('Caldas Novas', 'GO'), ('Cidade Ocidental', 'GO'), ('Santo Antônio do Descoberto', 'GO'), ('Goianésia', 'GO'), ('Mineiros', 'GO');

-- MA - Maranhão
INSERT INTO brazil_city (name, state_code) VALUES
('São Luís', 'MA'), ('Imperatriz', 'MA'), ('São José de Ribamar', 'MA'), ('Timon', 'MA'), ('Caxias', 'MA'),
('Codó', 'MA'), ('Paço do Lumiar', 'MA'), ('Açailândia', 'MA'), ('Bacabal', 'MA'), ('Balsas', 'MA'),
('Santa Inês', 'MA'), ('Chapadinha', 'MA'), ('Barra do Corda', 'MA'), ('Pinheiro', 'MA'), ('Buriticupu', 'MA');

-- MT - Mato Grosso
INSERT INTO brazil_city (name, state_code) VALUES
('Cuiabá', 'MT'), ('Várzea Grande', 'MT'), ('Rondonópolis', 'MT'), ('Sinop', 'MT'), ('Tangará da Serra', 'MT'),
('Cáceres', 'MT'), ('Sorriso', 'MT'), ('Lucas do Rio Verde', 'MT'), ('Primavera do Leste', 'MT'), ('Barra do Garças', 'MT'),
('Alta Floresta', 'MT'), ('Nova Mutum', 'MT'), ('Pontes e Lacerda', 'MT'), ('Campo Verde', 'MT'), ('Juína', 'MT');

-- MS - Mato Grosso do Sul
INSERT INTO brazil_city (name, state_code) VALUES
('Campo Grande', 'MS'), ('Dourados', 'MS'), ('Três Lagoas', 'MS'), ('Corumbá', 'MS'), ('Ponta Porã', 'MS'),
('Naviraí', 'MS'), ('Nova Andradina', 'MS'), ('Aquidauana', 'MS'), ('Sidrolândia', 'MS'), ('Paranaíba', 'MS'),
('Maracaju', 'MS'), ('Amambai', 'MS'), ('Coxim', 'MS'), ('Rio Brilhante', 'MS'), ('Cassilândia', 'MS');

-- MG - Minas Gerais
INSERT INTO brazil_city (name, state_code) VALUES
('Belo Horizonte', 'MG'), ('Uberlândia', 'MG'), ('Contagem', 'MG'), ('Juiz de Fora', 'MG'), ('Betim', 'MG'),
('Montes Claros', 'MG'), ('Ribeirão das Neves', 'MG'), ('Uberaba', 'MG'), ('Governador Valadares', 'MG'), ('Ipatinga', 'MG'),
('Santa Luzia', 'MG'), ('Sete Lagoas', 'MG'), ('Divinópolis', 'MG'), ('Poços de Caldas', 'MG'), ('Patos de Minas', 'MG'),
('Pouso Alegre', 'MG'), ('Teófilo Otoni', 'MG'), ('Barbacena', 'MG'), ('Sabará', 'MG'), ('Varginha', 'MG'),
('Conselheiro Lafaiete', 'MG'), ('Vespasiano', 'MG'), ('Itabira', 'MG'), ('Araguari', 'MG'), ('Passos', 'MG'),
('Pará de Minas', 'MG'), ('Coronel Fabriciano', 'MG'), ('Muriaé', 'MG'), ('Ituiutaba', 'MG'), ('Lavras', 'MG');

-- PA - Pará
INSERT INTO brazil_city (name, state_code) VALUES
('Belém', 'PA'), ('Ananindeua', 'PA'), ('Santarém', 'PA'), ('Marabá', 'PA'), ('Castanhal', 'PA'),
('Parauapebas', 'PA'), ('Abaetetuba', 'PA'), ('Cametá', 'PA'), ('Marituba', 'PA'), ('Bragança', 'PA'),
('Tucuruí', 'PA'), ('Altamira', 'PA'), ('Barcarena', 'PA'), ('Tailândia', 'PA'), ('Paragominas', 'PA'),
('Itaituba', 'PA'), ('Redenção', 'PA'), ('São Félix do Xingu', 'PA'), ('Breves', 'PA'), ('Benevides', 'PA');

-- PB - Paraíba
INSERT INTO brazil_city (name, state_code) VALUES
('João Pessoa', 'PB'), ('Campina Grande', 'PB'), ('Santa Rita', 'PB'), ('Patos', 'PB'), ('Bayeux', 'PB'),
('Sousa', 'PB'), ('Cajazeiras', 'PB'), ('Cabedelo', 'PB'), ('Guarabira', 'PB'), ('Sapé', 'PB'),
('Mamanguape', 'PB'), ('Queimadas', 'PB'), ('Pombal', 'PB'), ('Monteiro', 'PB'), ('Esperança', 'PB');

-- PR - Paraná
INSERT INTO brazil_city (name, state_code) VALUES
('Curitiba', 'PR'), ('Londrina', 'PR'), ('Maringá', 'PR'), ('Ponta Grossa', 'PR'), ('Cascavel', 'PR'),
('São José dos Pinhais', 'PR'), ('Foz do Iguaçu', 'PR'), ('Colombo', 'PR'), ('Guarapuava', 'PR'), ('Paranaguá', 'PR'),
('Araucária', 'PR'), ('Toledo', 'PR'), ('Apucarana', 'PR'), ('Pinhais', 'PR'), ('Campo Largo', 'PR'),
('Almirante Tamandaré', 'PR'), ('Umuarama', 'PR'), ('Fazenda Rio Grande', 'PR'), ('Paranavaí', 'PR'), ('Sarandi', 'PR'),
('Francisco Beltrão', 'PR'), ('Campo Mourão', 'PR'), ('Piraquara', 'PR'), ('Cambé', 'PR'), ('Arapongas', 'PR');

-- PE - Pernambuco
INSERT INTO brazil_city (name, state_code) VALUES
('Recife', 'PE'), ('Jaboatão dos Guararapes', 'PE'), ('Olinda', 'PE'), ('Caruaru', 'PE'), ('Petrolina', 'PE'),
('Paulista', 'PE'), ('Cabo de Santo Agostinho', 'PE'), ('Camaragibe', 'PE'), ('Garanhuns', 'PE'), ('Vitória de Santo Antão', 'PE'),
('Igarassu', 'PE'), ('São Lourenço da Mata', 'PE'), ('Abreu e Lima', 'PE'), ('Serra Talhada', 'PE'), ('Araripina', 'PE'),
('Santa Cruz do Capibaribe', 'PE'), ('Gravatá', 'PE'), ('Carpina', 'PE'), ('Goiana', 'PE'), ('Belo Jardim', 'PE');

-- PI - Piauí
INSERT INTO brazil_city (name, state_code) VALUES
('Teresina', 'PI'), ('Parnaíba', 'PI'), ('Picos', 'PI'), ('Piripiri', 'PI'), ('Floriano', 'PI'),
('Campo Maior', 'PI'), ('Barras', 'PI'), ('União', 'PI'), ('Altos', 'PI'), ('José de Freitas', 'PI'),
('Pedro II', 'PI'), ('Oeiras', 'PI'), ('Esperantina', 'PI'), ('Bom Jesus', 'PI'), ('São Raimundo Nonato', 'PI');

-- RJ - Rio de Janeiro
INSERT INTO brazil_city (name, state_code) VALUES
('Rio de Janeiro', 'RJ'), ('São Gonçalo', 'RJ'), ('Duque de Caxias', 'RJ'), ('Nova Iguaçu', 'RJ'), ('Niterói', 'RJ'),
('Belford Roxo', 'RJ'), ('Campos dos Goytacazes', 'RJ'), ('São João de Meriti', 'RJ'), ('Petrópolis', 'RJ'), ('Volta Redonda', 'RJ'),
('Magé', 'RJ'), ('Itaboraí', 'RJ'), ('Mesquita', 'RJ'), ('Nova Friburgo', 'RJ'), ('Barra Mansa', 'RJ'),
('Macaé', 'RJ'), ('Cabo Frio', 'RJ'), ('Nilópolis', 'RJ'), ('Teresópolis', 'RJ'), ('Queimados', 'RJ'),
('Angra dos Reis', 'RJ'), ('São Pedro da Aldeia', 'RJ'), ('Resende', 'RJ'), ('Maricá', 'RJ'), ('Araruama', 'RJ');

-- RN - Rio Grande do Norte
INSERT INTO brazil_city (name, state_code) VALUES
('Natal', 'RN'), ('Mossoró', 'RN'), ('Parnamirim', 'RN'), ('São Gonçalo do Amarante', 'RN'), ('Ceará-Mirim', 'RN'),
('Macaíba', 'RN'), ('Caicó', 'RN'), ('Açu', 'RN'), ('Currais Novos', 'RN'), ('São José de Mipibu', 'RN'),
('Nova Cruz', 'RN'), ('Apodi', 'RN'), ('João Câmara', 'RN'), ('Santa Cruz', 'RN'), ('Pau dos Ferros', 'RN');

-- RS - Rio Grande do Sul
INSERT INTO brazil_city (name, state_code) VALUES
('Porto Alegre', 'RS'), ('Caxias do Sul', 'RS'), ('Pelotas', 'RS'), ('Canoas', 'RS'), ('Santa Maria', 'RS'),
('Gravataí', 'RS'), ('Viamão', 'RS'), ('Novo Hamburgo', 'RS'), ('São Leopoldo', 'RS'), ('Rio Grande', 'RS'),
('Alvorada', 'RS'), ('Passo Fundo', 'RS'), ('Sapucaia do Sul', 'RS'), ('Uruguaiana', 'RS'), ('Santa Cruz do Sul', 'RS'),
('Cachoeirinha', 'RS'), ('Bagé', 'RS'), ('Bento Gonçalves', 'RS'), ('Erechim', 'RS'), ('Guaíba', 'RS'),
('Cachoeira do Sul', 'RS'), ('Santana do Livramento', 'RS'), ('Esteio', 'RS'), ('Ijuí', 'RS'), ('Alegrete', 'RS');

-- RO - Rondônia
INSERT INTO brazil_city (name, state_code) VALUES
('Porto Velho', 'RO'), ('Ji-Paraná', 'RO'), ('Ariquemes', 'RO'), ('Vilhena', 'RO'), ('Cacoal', 'RO'),
('Rolim de Moura', 'RO'), ('Jaru', 'RO'), ('Guajará-Mirim', 'RO'), ('Ouro Preto do Oeste', 'RO'), ('Pimenta Bueno', 'RO');

-- RR - Roraima
INSERT INTO brazil_city (name, state_code) VALUES
('Boa Vista', 'RR'), ('Rorainópolis', 'RR'), ('Caracaraí', 'RR'), ('Alto Alegre', 'RR'), ('Mucajaí', 'RR'),
('Cantá', 'RR'), ('Pacaraima', 'RR'), ('Amajari', 'RR'), ('Bonfim', 'RR'), ('Normandia', 'RR');

-- SC - Santa Catarina
INSERT INTO brazil_city (name, state_code) VALUES
('Joinville', 'SC'), ('Florianópolis', 'SC'), ('Blumenau', 'SC'), ('São José', 'SC'), ('Chapecó', 'SC'),
('Itajaí', 'SC'), ('Criciúma', 'SC'), ('Jaraguá do Sul', 'SC'), ('Palhoça', 'SC'), ('Lages', 'SC'),
('Balneário Camboriú', 'SC'), ('Brusque', 'SC'), ('Tubarão', 'SC'), ('São Bento do Sul', 'SC'), ('Caçador', 'SC'),
('Concórdia', 'SC'), ('Camboriú', 'SC'), ('Navegantes', 'SC'), ('Rio do Sul', 'SC'), ('Araranguá', 'SC');

-- SP - São Paulo
INSERT INTO brazil_city (name, state_code) VALUES
('São Paulo', 'SP'), ('Guarulhos', 'SP'), ('Campinas', 'SP'), ('São Bernardo do Campo', 'SP'), ('Santo André', 'SP'),
('Osasco', 'SP'), ('São José dos Campos', 'SP'), ('Ribeirão Preto', 'SP'), ('Sorocaba', 'SP'), ('Mauá', 'SP'),
('São José do Rio Preto', 'SP'), ('Santos', 'SP'), ('Mogi das Cruzes', 'SP'), ('Diadema', 'SP'), ('Jundiaí', 'SP'),
('Piracicaba', 'SP'), ('Carapicuíba', 'SP'), ('Bauru', 'SP'), ('Itaquaquecetuba', 'SP'), ('São Vicente', 'SP'),
('Franca', 'SP'), ('Praia Grande', 'SP'), ('Guarujá', 'SP'), ('Taubaté', 'SP'), ('Limeira', 'SP'),
('Suzano', 'SP'), ('Taboão da Serra', 'SP'), ('Sumaré', 'SP'), ('Embu das Artes', 'SP'), ('Barueri', 'SP'),
('Marília', 'SP'), ('Cotia', 'SP'), ('Americana', 'SP'), ('Indaiatuba', 'SP'), ('Araraquara', 'SP'),
('Presidente Prudente', 'SP'), ('Santa Bárbara d''Oeste', 'SP'), ('São Caetano do Sul', 'SP'), ('Jacareí', 'SP'), ('Hortolândia', 'SP'),
('Itapevi', 'SP'), ('Ferraz de Vasconcelos', 'SP'), ('Itapecerica da Serra', 'SP'), ('Francisco Morato', 'SP'), ('Franco da Rocha', 'SP');

-- SE - Sergipe
INSERT INTO brazil_city (name, state_code) VALUES
('Aracaju', 'SE'), ('Nossa Senhora do Socorro', 'SE'), ('Lagarto', 'SE'), ('Itabaiana', 'SE'), ('São Cristóvão', 'SE'),
('Estância', 'SE'), ('Tobias Barreto', 'SE'), ('Itabaianinha', 'SE'), ('Simão Dias', 'SE'), ('Capela', 'SE'),
('Própria', 'SE'), ('Barra dos Coqueiros', 'SE'), ('Nossa Senhora da Glória', 'SE'), ('Poço Redondo', 'SE'), ('Carmópolis', 'SE');

-- TO - Tocantins
INSERT INTO brazil_city (name, state_code) VALUES
('Palmas', 'TO'), ('Araguaína', 'TO'), ('Gurupi', 'TO'), ('Porto Nacional', 'TO'), ('Paraíso do Tocantins', 'TO'),
('Araguatins', 'TO'), ('Colinas do Tocantins', 'TO'), ('Guaraí', 'TO'), ('Tocantinópolis', 'TO'), ('Dianópolis', 'TO'),
('Formoso do Araguaia', 'TO'), ('Miracema do Tocantins', 'TO'), ('Augustinópolis', 'TO'), ('Pedro Afonso', 'TO'), ('Taguatinga', 'TO');

-- Verificar contagem final
SELECT 'Estados: ' || COUNT(*) FROM brazil_state;
SELECT 'Cidades: ' || COUNT(*) FROM brazil_city;
