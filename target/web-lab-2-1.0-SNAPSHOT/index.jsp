<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="#"/>
    <title>Web lab №2</title>
    <style>
        body {
            overflow-x: hidden;
            overflow-y: visible;
            animation-name: bg-animation;
            animation-duration: 10s;
            animation-iteration-count: infinite;
            animation-timing-function: ease-in-out;
        }

        @keyframes bg-animation {
            0%      {background-color: #15a7a7;}
            25%     {background-color: #0bc9c3;}
            50%     {background-color: #176969;}
            75%     {background-color: #0bc9c3;}
            100%    {background-color: #15a7a7;}
        }
        header {
            padding: 8px;
            font-family: cursive;
            background-color: #e2e2e2;
        }

        header h1 {
            margin: 0
        }

        header h1:first-letter {
            color: red;
        }

        header h2 {
            margin: 0
        }

        .container {
            padding: 8px;
        }

        .param {
            margin-top: 2%;
        }

        .param.x-param {
            margin-left: 39%;
        }

        .param.y-param {
            margin-left: 44%;
        }

        .param.r-param {
            margin-left: 43%;
        }

        .select {
            display: flex;
            margin-right: 8px;
        }


        #xRadio {
        }

        #rRadio {

        }

        .rRadio {
            height: 40px;
            width: 80px;
            margin: 8px;
        }

        #imageContainer{
            padding-top: 5%;
            width: 300px;
            height: 300px;
            margin: auto;
        }
        #graph-canvas {
            position: absolute;
            left: 0;
            right: 0;
            margin: 0 auto;
        }
        #result-grid{
            height: 300px;
            width: 300px;
            text-align: center;
        }

        .submit-button {
            margin-left: 44%;
            width: 200px;
            height: 64px;
        }

        #errors {
            grid-area: err;
            list-style-type: none
        }

        #result-table {
            grid-area: tbl;
            width: 100%;
            text-align: center;
            border-collapse: collapse;
            color: white;
        }

        #result-table tr {
            height: 2em;
        }

        #result-table tr.table-header:hover {
            background-color: #c8b5e9;
        }

        .coords-col {
            width: 12%;
        }

        .time-col {
            width: 25%;
        }

        tr {
            background-color: gray;
        }

        tr.hit-no {
            font-style: italic;
            color: black;
            background-color: indianred;
        }

        tr.hit-yes {
            color: initial;
            background-color: lightgreen;
        }


    </style>
</head>
<body>
<header>
    <h1>Лабораторная работа №2. Вариант 13509</h1>
    <h2>Жамков Иван, P3213</h2>
</header>
<div id="imageContainer">
    <object id="result-grid" type="image/svg+xml" data="img/graph.svg" ></object>
    <canvas id="graph-canvas" width="300" height="300">Интерактивная область графика</canvas>
</div>
<div class="param x-param">
    <label for="xRadio">X:</label>
    <div>
        <div id="xRadio" class="options">
            <% for (int i = -5; i <= 3  ; i++) { %>
            <label>
                <input type="radio" class="x-param" name="xval" value="<%=i%>" onclick="choosX(this)">
                <%=i%>
            </label>
            <% } %>
        </div>
    </div>
</div>

<div class="param y-param">
    <label for="y-input">Y: </label>
    <input id="y-input" type="text" name="yval" maxlength="5" autocomplete="off" placeholder="(-5; 5)">
</div>

<div class="param r-param">
    <label for="rRadio">R: </label>
    <div id="inputR">
            <div id="rRadio" class="options">
                <%double k = 0.5;%>
                <% for (int i = 1; i <= 5; i++) { %>
                <%k += 0.5;%>
                <label>
                    <input type="radio" name="rval" class="r-param" value="<%=k%>" onclick="choosR(this)">
                    <%=k%>
                </label>
                <% } %>
            </div>
    </div>
</div>
<input class="submit-button" id="submit-button" type="submit" value="Submit" onclick="submit()">
<ul id="errors" style="list-style-type: none"></ul>
<table id="result-table" class="result-table">
    <tr class="table-header">
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>Локальное время</th>
        <th>Время исполнения</th>
        <th>Попадание</th>
    </tr>
</table>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://d3js.org/d3.v7.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>