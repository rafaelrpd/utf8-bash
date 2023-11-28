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


#!/bin/bash

log_file="log.txt"
directory="$1"
target_extension=".txt"  # Altere para a extensão desejada

# Função para verificar o encoding de um arquivo
check_encoding() {
    file="$1"
    encoding=$(file -i "$file" | awk -F "=" '{print $2}')
    echo "Arquivo: $file"
    echo "Encode: $encoding"
    echo "-------------------------------------"
    echo "Arquivo: $file" >> "$log_file"
    echo "Encode: $encoding" >> "$log_file"
    echo "-------------------------------------" >> "$log_file"
}

# Função para alterar o encoding de um arquivo
change_encoding() {
    file="$1"
    encoding="$2"
    iconv -f "$encoding" -t UTF-8 "$file" > "$file.tmp"
    mv "$file.tmp" "$file"
}

# Função para percorrer arquivos e pastas
traverse_directory() {
    for entry in "$1"/*; do
        if [[ -f "$entry" ]]; then
            check_encoding "$entry"
            if [[ "$change_all" == true ]]; then
                change_encoding "$entry" "$new_encoding"
            fi
        elif [[ -d "$entry" ]]; then
            traverse_directory "$entry"
        fi
    done
}

# Opções do script
while getopts "e:pdah" option; do
    case $option in
        e)
            change_extension=true
            target_extension=".$OPTARG"
            ;;
        p)
            change_by_folder=true
            ;;
        a)
            change_all=true
            ;;
        d)
            enable_logging=true
            ;;
        h)
            echo "Uso: $0 [-e EXTENSÃO] [-p] [-a] [-d] DIRETÓRIO"
            echo "  -e EXTENSÃO  : Altera o encoding dos arquivos com a extensão especificada"
            echo "  -p           : Altera o encoding dos arquivos por extensão e pasta"
            echo "  -a           : Altera o encoding de todos os arquivos"
            echo "  -d           : Ativa o log de arquivos, caminhos, extensões e encodes"
            echo "  -h           : Exibe esta mensagem de ajuda"
            exit 0
            ;;
        *)
            echo "Opção inválida. Use -h para exibir a ajuda."
            exit 1
            ;;
    esac
done

# Verifica se o diretório foi especificado
if [[ $# -eq 0 ]]; then
    echo "Diretório não especificado. Use -h para exibir a ajuda."
    exit 1
fi

# Cria o arquivo de log, se ativado
if [[ "$enable_logging" == true ]]; then
    if [[ -f "$log_file" ]]; then
        rm "$log_file"
    fi
    touch "$log_file"
fi

# Verifica o encoding dos arquivos e pastas
if [[ "$change_extension" == true ]]; then
    echo "Alterando encoding para a extensão: $target_extension"
    traverse_directory "$directory"
elif [[ "$change_by_folder" == true ]]; then
    echo "Alterando encoding por extensão e pasta"
    find "$directory" -type d | while read -r folder; do
        find "$folder" -maxdepth 1 -type f -name "*$target_extension" | while read -r file; do
            check_encoding "$file"
            if [[ "$change_all" == true ]]; then
                change_encoding "$file" "$new_encoding"
            fi
        done
    done
else
    echo "Verificando encoding de todos os arquivos"
    traverse_directory "$directory"
fi
