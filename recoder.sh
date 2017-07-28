#!/bin/bash
#
# testa se a data recebida, no formato do MySQL, é válida ou não
checa_data(){
[ $(echo "$1" | sed 's,[12][0-9]\{3\}/\(0[1-9]\|1[012]\)/\(0[1-9]\|[12][0-9]\|3[01]\),,') ] &&
return 1 || return 0
}
				      
echo "Entre com os dados para incluir no registro"
echo
read -p "Numero de patrimonio: " numero_patrimonio
read -p "Setor: " setor
read -p "Descrição do computador: " descricao_micro
read -p "Problema: " problema
read -p "Serviço: " servico
read -p "Troca de peça: " troca_de_peca
read -n2 -p "Data (dia/mes/ano): " dia
read -n2 -p "/" mes
read -n4 -p "/" ano
echo
			  
# variável  data no formato do MySQL
data="$ano/$mes/$dia"
echo
				  
# se a data não for nula
if [ "$ano" -o "$mes" -o "$dia" ];then
# testa se a data é válida
checa_data "$data" || { echo "ERRO: Data de aniversário inválida";exit; }
fi
									    
# não pode haver  nomes nulo
[ "$numero_patrimonio" ] || { echo "ERRO: nome inválido";exit; }
								  
read -p "Deseja Incluir (s/n)? "

if [ "$REPLY" = "s" ];then
mysql -u root -p\
		 
"INSERT INTO REGISTROS VALUES('$numero_patrimonio','$setor','$descricao_micro','$problema','$servico','$troca_de_peca','$data')" mysql_bash

	[ "$?" = "0" ] && echo "Operacao OK" || echo "Operação: ERRO"
	fi
