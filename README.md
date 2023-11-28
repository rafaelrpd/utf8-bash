# utf8-bash
Este script de bash serve para mudar o encoding de arquivos para utf-8.

:'Este script aceita os seguintes parâmetros de linha de comando:

    -e EXTENSÃO: Altera o encoding dos arquivos com a extensão especificada.
    -p: Altera o encoding dos arquivos por extensão e pasta.
    -a: Altera o encoding de todos os arquivos.
    -d: Ativa o log de arquivos, caminhos, extensões e encodes.
    -h: Exibe a mensagem de ajuda.

Por exemplo, para verificar o encoding de todos os arquivos no diretório "my_directory" e fazer um log dos resultados, você pode executar o script da seguinte maneira:
	./script.sh -d my_directory
	
Se desejar alterar o encoding de todos os arquivos .txt para UTF-8 no diretório "my_directory" e suas subpastas, você pode usar o seguinte comando:
	./script.sh -a my_directory
	
	Instruções de Uso do Script
1. Opção -e (Alterar Encoding por Extensão de Arquivo)

    Uso: ./script.sh -e extensao diretorio
    Descrição: Altera o encoding de arquivos com a extensão especificada no diretório fornecido.
    Exemplo: Para alterar o encoding de todos os arquivos .txt no diretório "my_directory", use ./script.sh -e txt my_directory.

2. Opção -p (Alterar Encoding por Extensão e Pasta)

    Uso: ./script.sh -p diretorio
    Descrição: Altera o encoding de arquivos baseando-se na extensão e na estrutura de pastas.
    Exemplo: Para alterar o encoding de arquivos .txt (ou a extensão definida em target_extension) em cada pasta do diretório "my_directory", use ./script.sh -p my_directory.

3. Opção -a (Alterar Encoding de Todos os Arquivos)

    Uso: ./script.sh -a diretorio
    Descrição: Altera o encoding de todos os arquivos no diretório fornecido, independentemente de sua extensão.
    Exemplo: Para alterar o encoding de todos os arquivos no diretório "my_directory", use ./script.sh -a my_directory.

4. Opção -d (Ativar Log)

    Uso: ./script.sh -d diretorio
    Descrição: Ativa o log de arquivos, caminhos, extensões e encodes. Esta opção pode ser combinada com outras.
    Exemplo: Para ativar o log enquanto verifica o encoding de todos os arquivos em "my_directory", use ./script.sh -d -a my_directory.

5. Opção -h (Ajuda)

    Uso: ./script.sh -h
    Descrição: Exibe a mensagem de ajuda, explicando o uso e as opções do script.
    Exemplo: Para exibir a ajuda, use ./script.sh -h.

Notas Adicionais

    O script está configurado para alterar o encoding para UTF-8.
    O script precisa de permissão de execução. Use chmod +x script.sh para conceder permissão de execução, se necessário.
    Certifique-se de ter as permissões adequadas para ler e escrever nos arquivos e diretórios especificados.
Lembre-se de que o script atualmente suporta apenas a alteração de encoding para UTF-8. Se você precisar de suporte para outros encodings, você pode modificar o script de acordo com suas necessidades.

Feito por Rafael Pereira Dias - 02/03/2023 - br.rafaeldias@gmail.com
'
