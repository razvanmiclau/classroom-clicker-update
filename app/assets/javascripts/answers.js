// GLOBAL VARIABLES
var colors = ["cornflowerblue",
  "olivedrab",
  "orange",
  "tomato",
  "crimson",
  "purple",
  "turquoise",
  "forestgreen",
  "navy",
  "gray"
];

var barChart;
var pieChart;
var answers = [];
var dataRequest;

$('.questions.show').ready(function(){
  // URLs
  var dataURL = '/questions/' + question_id + '/data';
  var dataTableURL = '/questions/' + question_id + '/dataTable';

  // GET json data and pass it to charts
  var fetchData = function(){
    dataRequest = $.ajax({
      url: dataURL,
      dataType: 'json',
      cache: false,
      async: true,
      success: function(data){
        getData(data.answers);
        getWords(data.words);
        getColumnData(data.total);
        getPieData(data.total);
        setTimeout(fetchData, 2000);
      }
    });
  };

  // Column-chart options
  var columnOptions = {
    chart: {
      renderTo: 'bar-chart',
      type: 'column',
      events: {load: function(){
        fetchData();
      }}
    }
  };

// Pie-chart options
  var pieOptions = {
    chart: {
      renderTo : 'pie-chart',
      type: 'pie',
      events: {load: function() {
          fetchData();
        }
      }
    },
    plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                },
                showInLegend: true
            }
        }
  };

  // Append specific chart options to the default chart
  columnOptions = $.extend(true, {}, defaultOptions, columnOptions);
  pieOptions = $.extend(true, {}, defaultOptions, pieOptions);

  // Call charts
  barChart = new Highcharts.Chart(columnOptions);
  pieChart = new Highcharts.Chart(pieOptions);
  //drawColumnChart(fetchData);
  //drawPieChart(fetchData);

  // Toggle Fullscreen - Share results
    $('.toggle-fullscreen').on('click', function(){
      var targetElement = $('.screen')[0];
      if(screenfull.enabled){
        screenfull.toggle(targetElement);
      }
    });

});

// Default Chart Options - options shared by all charts
var defaultOptions = {
  title: {text: null},
  xAxis: {answers: answers},
  yAxis: {title: {text: null}},
  series: [{name: 'Votes', data: []}]
};

// pass json data to the column-chart
var getColumnData = function(dt){
  var categories = [] ;
  var answer = [];
    $.each(dt, function(i,e){
      categories.push(i);
      answer.push(parseInt(e));
    });
  barChart.xAxis[0].setCategories(categories);
  barChart.series[0].setData(answer);
};

// pass json data to the pie-chart
var getPieData = function(dt){
  var dataObjectArray = [];
    $.each(dt, function(i,e){
      dataobj = {
        name: i, y: e
      }
      dataObjectArray.push(dataobj);
    });
  pieChart.series[0].setData(dataObjectArray);
};

// pass json data to cards
var getData = function(dt){
  $('#lect-answers').children().remove();
    for (var i = 0; i < dt.length; i++) {
      var strVar="";
      strVar += "<div class=\"col-sm-3\">";
      strVar += "<div class=\"card\">";
      strVar += "<div class=\"content\">";
      strVar += "<h4>"+"\""+dt[i].value+"\""+"<\/h4>";
      strVar += "<div class=\"footer\">";
      strVar += "<hr>";
      strVar += "<div class=\"stats\">"+ moment(dt[i].created_at).fromNow() + "<\/div>";
      strVar += "<\/div>";
      strVar += "<\/div>";
      strVar += "<\/div>";
      strVar += "<\/div>";
      $('#lect-answers').append(strVar);
    }
};

// pass json data to word cloud
var getWords = function(dt){
  var initialArray = [];
  var words_array = [];
  for(var element in dt){
    initialArray.push(dt[element]);
  }
  words_array = createObjectArray(initialArray);
  $("#cloud").jQCloud(words_array ,{
      autoResize: true,
      colors: colors,
      fontSize: { from: 0.1, to: 0.04 }
    });
    $('#cloud').jQCloud('update', words_array);
};

// Creates an object array - word cloud data format
// Algorithm based on this solution https://gist.github.com/ralphcrisostomo/3141412
function createObjectArray(wordsArray){
  var objectArray = [];
  var copyArray = wordsArray.slice(0);

  for(var i=0; i < wordsArray.length; i++){
    var counter = 0;
    for(var y=0; y < copyArray.length; y++){
      if(wordsArray[i] == copyArray[y]){
        counter++;
        delete copyArray[y];
      }
    }
    if(counter > 0){
      var obj = new Object();
        obj.text = wordsArray[i];
        obj.weight = counter;
        objectArray.push(obj);
    }
  }
  return objectArray;
};
