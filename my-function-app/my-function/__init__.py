import logging
import os
import azure.functions as func
from azure.storage.blob import BlobServiceClient
import random
from datetime import datetime

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Azure Function disparada para modificar o conteúdo do arquivo.')

    # Parâmetros da função - nome do arquivo passado via ADF (query string ou corpo da requisição)
    arquivo_nome = req.params.get('arquivo_nome')
    if not arquivo_nome:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            arquivo_nome = req_body.get('arquivo_nome')

    if not arquivo_nome:
        return func.HttpResponse("Por favor, passe o nome do arquivo na requisição.", status_code=400)

    # Conexão ao Blob Storage usando variáveis de ambiente
    connection_string = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
    container_name = os.getenv('AZURE_STORAGE_CONTAINER_NAME')

    if not connection_string or not container_name:
        return func.HttpResponse("As variáveis de ambiente de conexão não estão configuradas.", status_code=500)

    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=arquivo_nome)

    # Ler o conteúdo do arquivo existente
    try:
        blob_data = blob_client.download_blob().readall().decode('utf-8')
        logging.info(f"Conteúdo original do arquivo: {blob_data}")
    except Exception as e:
        return func.HttpResponse(f"Erro ao ler o arquivo: {str(e)}", status_code=500)

    # Gerar um novo número aleatório de 7 dígitos
    novo_numero = str(random.randint(1000000, 9999999))

    # Substituir o conteúdo antigo pelo novo número
    novo_conteudo = novo_numero
    logging.info(f"Novo conteúdo: {novo_conteudo}")

    # Gerar o nome do novo arquivo com data
    data_criacao = datetime.now().strftime("%Y%m%d")
    novo_arquivo_nome = f"matricula{data_criacao}.txt"

    # Upload do novo arquivo no Blob Storage
    novo_blob_client = blob_service_client.get_blob_client(container=container_name, blob=novo_arquivo_nome)
    try:
        novo_blob_client.upload_blob(novo_conteudo, overwrite=True)
        logging.info(f"Arquivo salvo como {novo_arquivo_nome}")
    except Exception as e:
        return func.HttpResponse(f"Erro ao salvar o novo arquivo: {str(e)}", status_code=500)

    return func.HttpResponse(f"Arquivo modificado com sucesso. Novo arquivo: {novo_arquivo_nome}", status_code=200)
