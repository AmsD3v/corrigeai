--
-- PostgreSQL database dump
--

\restrict MdDSpnbgPNPrbiboSdaSll0YrIFKFcCZcCutinRBcjWiBJoU43YHgNXFdZeZpbj

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: challenge; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (1, 'daily', 'Redação Diária', 'Envie 1 redação hoje', '📝', 'submit_essay', 1, 15, 0, true);
INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (2, 'daily', 'Estudante Dedicado', 'Complete 1 lição hoje', '📚', 'complete_lesson', 1, 10, 0, true);
INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (3, 'daily', 'Reflexão', 'Leia o feedback de uma correção', '👁️', 'read_feedback', 1, 5, 0, true);
INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (4, 'weekly', 'Meta Semanal', 'Envie 3 redações esta semana', '🎯', 'submit_essay', 3, 50, 0, true);
INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (5, 'weekly', 'Maratona de Estudos', 'Complete 5 lições esta semana', '📖', 'complete_lesson', 5, 75, 0, true);
INSERT INTO public.challenge (id, challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward, is_active) VALUES (6, 'weekly', 'Streak da Semana', 'Mantenha 7 dias de atividade', '🔥', 'streak', 7, 100, 1, true);


--
-- Name: challenge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.challenge_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

\unrestrict MdDSpnbgPNPrbiboSdaSll0YrIFKFcCZcCutinRBcjWiBJoU43YHgNXFdZeZpbj

