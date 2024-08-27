Esse script Bash é projetado para automatizar um processo de reconhecimento e análise de segurança em um domínio alvo, utilizando diversas ferramentas populares. Ele inicia a enumeração de subdomínios com o 
`Subfinder` e `Findomain`, filtra resultados duplicados, e então utiliza `Httpx` para detectar tecnologias e verificar o status dos códigos HTTP, focando em respostas com código 200. Além disso, o script
captura screenshots dos alvos válidos, realiza um brute-force de diretórios com `Feroxbuster`, conduz uma varredura de portas com `Naabu` e `Nmap`, e, finalmente, aplica templates de vulnerabilidades com 
`Nuclei`. Esse fluxo automatizado permite a coleta de informações valiosas de maneira eficiente, facilitando a identificação de possíveis vetores de ataque em um alvo específico.
