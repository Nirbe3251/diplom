Highcharts.setOptions({
    global: { useUTC: false },
    lang: {
        loading: 'Загрузка...',
        months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль',
            'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
        ],
        weekdays: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
        shortMonths: ['Янв', 'Фев', 'Мрт', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
        decimalPoint: '.',
        resetZoom: 'Сброс увеличения',
        resetZoomTitle: 'Сбросить увеличение к масштабу 1:1',
        thousandsSep: ','
    },
    credits: { enabled: false }
});

Highcharts.stats_charts_config = () => {
    return {
        chart: {
            renderTo: '',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: '',
            height: 400,
            zoomType: 'x'
        },
        plotOptions: {
            pie: {
                allowPointSelect: false,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    formatter: function() {
                        return '<b>' + this.point.name + '</b>: ' + (this.percentage < 1 ? this.percentage.toFixed(2) : Math.round(this.percentage)) + ' %';
                    }
                }
            },
            spline: {
                marker: { enabled: false }
            }
        },
        title: { text: '' },
        tooltip: { shared: true },
        xAxis: { type: 'datetime' },
        yAxis: { title: { text: '' }, min: 0 }
    }
}