
# DW Redshift com Docker, Terraform e Metabase

Este projeto implementa uma solução completa de infraestrutura e ingestão de dados usando **Terraform**, **Docker** e o banco de dados **Amazon Redshift**. O objetivo é criar um pipeline de dados com estrutura organizada e automatizada.

---

## 📂 Estrutura do Projeto

### **Pasta: `etapa1`**
Contém os arquivos necessários para provisionar um cluster Redshift na AWS:
- `provider.tf`: Configura o provedor da AWS.
- `redshift.tf`: Cria o cluster Redshift.
- `redshift_role.tf`: Configura as permissões e funções necessárias para o cluster.

### **Pasta: `etapa2`**
Scripts para a modelagem física do banco de dados:
- `modelo_fisico.sql`: Cria tabelas, esquemas e faz a ingestão de dados a partir de arquivos armazenados no bucket S3.

### **Pasta: `etapa3`**
Automatiza o envio de arquivos para o bucket S3:
- `main.tf`: Configura e sobe um bucket S3 e faz upload de arquivos CSV que representam as dimensões do projeto.

### **Pasta: `dados`**
Contém os arquivos de dados para popular o DW:
- `dim_cliente.csv`: Dimensão Cliente.
- `dim_localidade.csv`: Dimensão Localidade.
- `dim_produto.csv`: Dimensão Produto.
- `dim_tempo.csv`: Dimensão Tempo.
- `fato_vendas.csv`: Tabela de fatos com os dados de vendas.

### **Dockerfile**
Configura uma imagem Docker personalizada com os seguintes recursos:
- **Base**: `Ubuntu:latest`.
- **Instalações**:
  - `Terraform v1.9.5` para provisionamento de infraestrutura.
  - `AWS CLI` para interagir com serviços AWS.
  - Ferramentas básicas (curl, wget, git, PostgreSQL, etc.).
- **Volumes**:
  - Monta `/iac` como ponto de volume para os arquivos de infraestrutura.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
1. **Docker** instalado ([Guia de instalação](https://docs.docker.com/get-docker/)).
2. **Terraform** instalado ([Guia de instalação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)).
3. Configuração da **AWS CLI** com chaves de acesso configuradas.

### Passo a Passo
1. Clone o repositório:
   ```bash
   git clone https://github.com/Rafa2704/DW_Redshift_docker_terraform_metabase.git
   cd DW_Redshift_docker_terraform_metabase
   ```
2. Construa a imagem Docker:
   ```bash
   docker build -t terraform-image .
   ```
3. Inicie o container Docker:
   ```bash
   docker run -it -v $(pwd):/iac terraform-image
   ```
4. Acesse o diretório `/iac` dentro do container:
   ```bash
   cd /iac
   ```
5. Execute as etapas de infraestrutura e carga de dados:
   - **Provisionar Redshift**: Vá para a pasta `etapa1` e execute:
     ```bash
     terraform init
     terraform apply
     ```
   - **Modelagem Física**: No Redshift, execute o script SQL em `etapa2/modelo_fisico.sql`.
   - **Upload para o S3**: Configure o bucket e faça upload dos dados da pasta `etapa3`.

---

## 📊 Visualização com Metabase
- Utilize o **Metabase** para criar dashboards com os dados do Redshift.
- Conecte o Redshift ao Metabase utilizando as credenciais do cluster.

---

## 🛠 Tecnologias Utilizadas
- **Terraform**: Provisionamento de infraestrutura.
- **AWS Redshift**: Data Warehouse.
- **S3**: Armazenamento de arquivos.
- **Docker**: Gerenciamento de containers.
- **Metabase**: Visualização de dados.

---
