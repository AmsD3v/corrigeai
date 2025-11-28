"""
Mercado Pago Payment Service
Handles payment preference creation and webhook processing
"""
import mercadopago
import os
from typing import Dict, Any
from datetime import datetime

class MercadoPagoService:
    def __init__(self):
        self.sdk = mercadopago.SDK(os.getenv("MP_ACCESS_TOKEN"))
        self.public_key = os.getenv("MP_PUBLIC_KEY")
    
    def create_preference(self, package_data: Dict[str, Any], user_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create a payment preference for Mercado Pago Checkout Pro
        
        Args:
            package_data: Dictionary with package information (id, name, price, coins)
            user_data: Dictionary with user information (id, email, name)
        
        Returns:
            Dictionary with preference data including init_point (checkout URL)
        """
        try:
            preference_data = {
                "items": [
                    {
                        "title": f"{package_data['name']} - {package_data['coins']} CorriCoins",
                        "quantity": 1,
                        "unit_price": float(package_data['price']),
                        "currency_id": "BRL"
                    }
                ],
                "payer": {
                    "email": user_data['email'],
                    "name": user_data.get('name', 'Usuário')
                },
                "back_urls": {
                    "success": f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/painel/pagamento/sucesso",
                    "failure": f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/painel/pagamento/falha",
                    "pending": f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/painel/pagamento/pendente"
                },
                "auto_return": "approved",  # Auto-redirect when payment is approved
                "binary_mode": True,  # Skip MP result page, redirect immediately
                "external_reference": f"user_{user_data['id']}_package_{package_data['id']}_{int(datetime.now().timestamp())}",
                "notification_url": f"{os.getenv('BACKEND_URL', 'http://localhost:3000')}/api/payment/webhook",
                "statement_descriptor": "CORRIGEAI",
                "metadata": {
                    "user_id": user_data['id'],
                    "package_id": package_data['id'],
                    "coins": package_data['coins'],
                    "bonus": package_data.get('bonus', 0)
                }
            }
            
            print(f"🔧 Creating MP preference with data: {preference_data}")
            preference_response = self.sdk.preference().create(preference_data)
            print(f"📡 MP Response status: {preference_response.get('status')}")
            print(f"📡 MP Response: {preference_response}")
            
            if preference_response["status"] == 201:
                return {
                    "success": True,
                    "preference_id": preference_response["response"]["id"],
                    "init_point": preference_response["response"]["init_point"],
                    "sandbox_init_point": preference_response["response"]["sandbox_init_point"]
                }
            else:
                print(f"❌ Failed to create preference. Response: {preference_response}")
                return {
                    "success": False,
                    "error": "Failed to create preference",
                    "details": preference_response
                }
        
        except Exception as e:
            print(f"❌ Exception creating preference: {str(e)}")
            import traceback
            traceback.print_exc()
            return {
                "success": False,
                "error": str(e)
            }
    
    def get_payment_info(self, payment_id: str) -> Dict[str, Any]:
        """
        Get payment information from Mercado Pago
        
        Args:
            payment_id: Payment ID from Mercado Pago
        
        Returns:
            Dictionary with payment information
        """
        try:
            payment_response = self.sdk.payment().get(payment_id)
            
            if payment_response["status"] == 200:
                payment_data = payment_response["response"]
                return {
                    "success": True,
                    "payment_id": payment_data["id"],
                    "status": payment_data["status"],
                    "status_detail": payment_data["status_detail"],
                    "transaction_amount": payment_data["transaction_amount"],
                    "external_reference": payment_data.get("external_reference"),
                    "metadata": payment_data.get("metadata", {}),
                    "payer_email": payment_data.get("payer", {}).get("email"),
                    "date_approved": payment_data.get("date_approved"),
                    "payment_method_id": payment_data.get("payment_method_id"),
                    "payment_type_id": payment_data.get("payment_type_id")
                }
            else:
                return {
                    "success": False,
                    "error": "Failed to get payment info"
                }
        
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }
    
    def process_webhook(self, webhook_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Process webhook notification from Mercado Pago
        
        Args:
            webhook_data: Webhook payload from Mercado Pago
        
        Returns:
            Dictionary with processing result
        """
        try:
            # Extract payment ID from webhook
            if webhook_data.get("type") == "payment":
                payment_id = webhook_data.get("data", {}).get("id")
                
                if payment_id:
                    # Get full payment information
                    payment_info = self.get_payment_info(str(payment_id))
                    
                    if payment_info["success"]:
                        return {
                            "success": True,
                            "payment_info": payment_info,
                            "should_process": payment_info["status"] == "approved"
                        }
            
            return {
                "success": False,
                "error": "Invalid webhook data"
            }
        
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }
