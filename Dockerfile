#imagem vai partir desse ponto
FROM tomcat:8.5.50-jdk8-openjdk 


ARG WAR_FILE
ARG CONTEXT

#adicionar a minha aplicação a esse tomcat 
#copiar vai realizar copia da origem do meu diretorio // até destino nessa imagem do tom cat
#destino pasta interna do tomcat da imagem onde as aplicações que são feitas deploy ficam
COPY ${WAR_FILE} /usr/local/tomcat/webapps/${CONTEXT}.war