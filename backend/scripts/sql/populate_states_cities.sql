-- Script para popular estados e cidades brasileiras
-- Estados
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

-- Cidades principais por estado
-- Acre
INSERT INTO brazil_city (name, state_code) VALUES ('Rio Branco', 'AC'), ('Cruzeiro do Sul', 'AC'), ('Sena Madureira', 'AC');
-- Alagoas  
INSERT INTO brazil_city (name, state_code) VALUES ('Maceió', 'AL'), ('Arapiraca', 'AL'), ('Rio Largo', 'AL');
-- Amapá
INSERT INTO brazil_city (name, state_code) VALUES ('Macapá', 'AP'), ('Santana', 'AP'), ('Laranjal do Jari', 'AP');
-- Amazonas
INSERT INTO brazil_city (name, state_code) VALUES ('Manaus', 'AM'), ('Parintins', 'AM'), ('Itacoatiara', 'AM');
-- Bahia
INSERT INTO brazil_city (name, state_code) VALUES ('Salvador', 'BA'), ('Feira de Santana', 'BA'), ('Vitória da Conquista', 'BA'), ('Camaçari', 'BA'), ('Itabuna', 'BA'), ('Juazeiro', 'BA');
-- Ceará
INSERT INTO brazil_city (name, state_code) VALUES ('Fortaleza', 'CE'), ('Caucaia', 'CE'), ('Juazeiro do Norte', 'CE'), ('Maracanaú', 'CE'), ('Sobral', 'CE');
-- Distrito Federal
INSERT INTO brazil_city (name, state_code) VALUES ('Brasília', 'DF'), ('Taguatinga', 'DF'), ('Ceilândia', 'DF');
-- Espírito Santo
INSERT INTO brazil_city (name, state_code) VALUES ('Vitória', 'ES'), ('Vila Velha', 'ES'), ('Serra', 'ES'), ('Cariacica', 'ES');
-- Goiás
INSERT INTO brazil_city (name, state_code) VALUES ('Goiânia', 'GO'), ('Aparecida de Goiânia', 'GO'), ('Anápolis', 'GO'), ('Rio Verde', 'GO');
-- Maranhão
INSERT INTO brazil_city (name, state_code) VALUES ('São Luís', 'MA'), ('Imperatriz', 'MA'), ('São José de Ribamar', 'MA'), ('Timon', 'MA');
-- Mato Grosso
INSERT INTO brazil_city (name, state_code) VALUES ('Cuiabá', 'MT'), ('Várzea Grande', 'MT'), ('Rondonópolis', 'MT'), ('Sinop', 'MT');
-- Mato Grosso do Sul
INSERT INTO brazil_city (name, state_code) VALUES ('Campo Grande', 'MS'), ('Dourados', 'MS'), ('Três Lagoas', 'MS'), ('Corumbá', 'MS');
-- Minas Gerais
INSERT INTO brazil_city (name, state_code) VALUES ('Belo Horizonte', 'MG'), ('Uberlândia', 'MG'), ('Contagem', 'MG'), ('Juiz de Fora', 'MG'), ('Betim', 'MG'), ('Montes Claros', 'MG'), ('Ribeirão das Neves', 'MG'), ('Uberaba', 'MG'), ('Governador Valadares', 'MG'), ('Ipatinga', 'MG');
-- Pará
INSERT INTO brazil_city (name, state_code) VALUES ('Belém', 'PA'), ('Ananindeua', 'PA'), ('Santarém', 'PA'), ('Marabá', 'PA');
-- Paraíba
INSERT INTO brazil_city (name, state_code) VALUES ('João Pessoa', 'PB'), ('Campina Grande', 'PB'), ('Santa Rita', 'PB'), ('Patos', 'PB');
-- Paraná
INSERT INTO brazil_city (name, state_code) VALUES ('Curitiba', 'PR'), ('Londrina', 'PR'), ('Maringá', 'PR'), ('Ponta Grossa', 'PR'), ('Cascavel', 'PR'), ('São José dos Pinhais', 'PR'), ('Foz do Iguaçu', 'PR');
-- Pernambuco
INSERT INTO brazil_city (name, state_code) VALUES ('Recife', 'PE'), ('Jaboatão dos Guararapes', 'PE'), ('Olinda', 'PE'), ('Caruaru', 'PE'), ('Petrolina', 'PE');
-- Piauí
INSERT INTO brazil_city (name, state_code) VALUES ('Teresina', 'PI'), ('Parnaíba', 'PI'), ('Picos', 'PI');
-- Rio de Janeiro
INSERT INTO brazil_city (name, state_code) VALUES ('Rio de Janeiro', 'RJ'), ('São Gonçalo', 'RJ'), ('Duque de Caxias', 'RJ'), ('Nova Iguaçu', 'RJ'), ('Niterói', 'RJ'), ('Belford Roxo', 'RJ'), ('São João de Meriti', 'RJ'), ('Campos dos Goytacazes', 'RJ'), ('Petrópolis', 'RJ');
-- Rio Grande do Norte
INSERT INTO brazil_city (name, state_code) VALUES ('Natal', 'RN'), ('Mossoró', 'RN'), ('Parnamirim', 'RN'), ('São Gonçalo do Amarante', 'RN');
-- Rio Grande do Sul
INSERT INTO brazil_city (name, state_code) VALUES ('Porto Alegre', 'RS'), ('Caxias do Sul', 'RS'), ('Pelotas', 'RS'), ('Canoas', 'RS'), ('Santa Maria', 'RS'), ('Gravataí', 'RS'), ('Viamão', 'RS'), ('Novo Hamburgo', 'RS');
-- Rondônia
INSERT INTO brazil_city (name, state_code) VALUES ('Porto Velho', 'RO'), ('Ji-Paraná', 'RO'), ('Ariquemes', 'RO');
-- Roraima
INSERT INTO brazil_city (name, state_code) VALUES ('Boa Vista', 'RR'), ('Rorainópolis', 'RR');
-- Santa Catarina
INSERT INTO brazil_city (name, state_code) VALUES ('Florianópolis', 'SC'), ('Joinville', 'SC'), ('Blumenau', 'SC'), ('São José', 'SC'), ('Criciúma', 'SC'), ('Chapecó', 'SC'), ('Itajaí', 'SC');
-- São Paulo
INSERT INTO brazil_city (name, state_code) VALUES ('São Paulo', 'SP'), ('Guarulhos', 'SP'), ('Campinas', 'SP'), ('São Bernardo do Campo', 'SP'), ('Santo André', 'SP'), ('Osasco', 'SP'), ('São José dos Campos', 'SP'), ('Ribeirão Preto', 'SP'), ('Sorocaba', 'SP'), ('Santos', 'SP'), ('Mauá', 'SP'), ('São José do Rio Preto', 'SP'), ('Mogi das Cruzes', 'SP'), ('Diadema', 'SP'), ('Jundiaí', 'SP'), ('Piracicaba', 'SP'), ('Carapicuíba', 'SP'), ('Bauru', 'SP'), ('Itaquaquecetuba', 'SP'), ('São Vicente', 'SP');
-- Sergipe
INSERT INTO brazil_city (name, state_code) VALUES ('Aracaju', 'SE'), ('Nossa Senhora do Socorro', 'SE'), ('Lagarto', 'SE');
-- Tocantins
INSERT INTO brazil_city (name, state_code) VALUES ('Palmas', 'TO'), ('Araguaína', 'TO'), ('Gurupi', 'TO');
