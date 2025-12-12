@app.get("/submissions/{submission_id}/correction", response_model=schemas.CorrectionDetail)
def get_correction(
    submission_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Get correction details for a specific submission.
    
    Returns detailed ENEM evaluation with scores for all 5 competencies,
    feedback, strengths, improvements, and general comments.
    """
    # Verify submission belongs to current user
    submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id,
        models.Submission.owner_id == current_user.id
    ).first()
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada ou acesso não permitido."
        )
    
    # Get correction
    correction = db.query(models.Correction).filter(
        models.Correction.submission_id == submission_id
    ).first()
    
    if not correction:
        # Check submission status
        if submission.status == "pending":
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Correção ainda não iniciada. Aguarde alguns instantes."
            )
        elif submission.status == "processing":
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Correção em andamento. Aguarde alguns instantes."
            )
        elif submission.status == "failed":
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Falha na correção. Seu crédito foi estornado. Tente novamente."
            )
        else:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Correção não disponível."
            )
    
    return correction
