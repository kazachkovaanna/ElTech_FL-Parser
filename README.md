# ElTech_FL-Parser
Windows + Java </br>
Скрипт для сборки buid.bat </br>
Запуск  </br>
java Main in.txt </br>
где in.txt - файл с текстом исходной программы. </br>
Дерево представляется в виде, где табуляцией представляется высота узла относительно корня, на новой строке с большим отсупом пишутся дети узла: </br>
    <pre>
s  
    var 
            x 
    := 
    expr 
            expr 
                    var 
                            x 
            == 
            expr 
                    num 
                            3 
</pre>
</br>

