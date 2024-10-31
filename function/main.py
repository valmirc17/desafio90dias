import json
import random
import string
import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    # Gera um código alfanumérico aleatório de 6 dígitos
    code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
    
    # Retorna o código em formato JSON
    response = {
        "code": code
    }

    return func.HttpResponse(
        json.dumps(response),
        mimetype="application/json",
        status_code=200
    )
