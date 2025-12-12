-- Criar tabela de feedback de correções
CREATE TABLE IF NOT EXISTS feedback (
    id SERIAL PRIMARY KEY,
    submission_id INTEGER NOT NULL REFERENCES submission(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    is_helpful BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    -- Prevent duplicate feedback per user per submission
    UNIQUE(submission_id, user_id)
);

-- Add indexes for better performance
CREATE INDEX IF NOT EXISTS idx_feedback_submission_id ON feedback(submission_id);
CREATE INDEX IF NOT EXISTS idx_feedback_user_id ON feedback(user_id);
CREATE INDEX IF NOT EXISTS idx_feedback_created_at ON feedback(created_at);

-- Verify table was created
SELECT table_name, column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'feedback'
ORDER BY ordinal_position;
