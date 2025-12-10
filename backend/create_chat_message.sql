-- Create chat_message table for AI Professor chat persistence
CREATE TABLE IF NOT EXISTS chat_message (
    id SERIAL PRIMARY KEY,
    submission_id INTEGER NOT NULL REFERENCES submission(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    role VARCHAR NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_chat_submission ON chat_message(submission_id);
CREATE INDEX IF NOT EXISTS idx_chat_user ON chat_message(user_id);
