# Solução

Para executar o deploy da solução, basta executar o comando abaixo no terminal.

**Pré-requisitos**: Para que o deploy seja executado com sucesso, é necessário que os seguintes programas estejam instalados: *Minikube, Kubectl, Helm, Docker e Unzip*. Também é necessário estar logado com usuário com privilégios SUDO.

``` wget https://github.com/thiagop4z/desafios-devops/archive/refs/heads/master.zip && unzip master.zip && cd desafios-devops-master/kubernetes/ && eval $(minikube docker-env) && docker build -t idwall:1.0 . && helm install idwall . && sudo -- sh -c "echo '$(minikube ip) idwall.cc' >> /etc/hosts" && sleep 10s && curl idwall.cc ```

## Descrição do *script* passo a passo

1. Baixa este repositório, descompacta e acessa pasta *kubernetes*:

``` wget https://github.com/thiagop4z/desafios-devops/archive/refs/heads/master.zip && unzip master.zip && cd desafios-devops-master/kubernetes/ ```

2. Acessa o *Docker daemon* do *Minikube* e cria a imagem *idwall:1.0* a partir do *Dockerfile*:

``` eval $(minikube docker-env) && docker build -t idwall:1.0 . ```

3. Faz o *deploy* da solução no *Minikube* utilizando o *Helm*:

``` helm install idwall . ```

4. Edita o arquivo /etc/hosts incluindo uma entrada que aponta o domínio *idwall.cc* para o ip do *Minikube* e aguarda 10 segundos para o término do *deploy*:

``` sudo -- sh -c "echo '$(minikube ip) idwall.cc' >> /etc/hosts" && sleep 10s ```

5. Acessa a URL da aplicação (idwall.cc)[http://idwall.cc], que deve retornar a mensagem "Olá Thiago!:

``` curl idwall.cc ```

## Comentários

1. Foram implementados todos os requisitos principais e extras;

2. Os recursos do *Kubernetes* foram alocados no *namespace "challenge"*;

3. *Heath check* implementado através do recurso *LivenessProbe* do *Kubernetes*;

4. Foi definida a variável de ambiente $NAME com o valor "Thiago", alterando assim a mensagem de saudação da aplicação para **"Olá, Thiago!"**.

5. A documentação do *Kubernetes* foi utilizada como material de apóio para o desenvolvimento da solução.

Thiago Paz.