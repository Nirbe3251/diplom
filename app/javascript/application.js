// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import Turbolinks from 'turbolinks'
import "bootstrap"
import '@popperjs/core'
import "highcharts"

import Rails from '@rails/ujs'
// import 'bootstrap-icons/font/bootstrap-icons.css'
import * as channels from "./channels"
import { initSideBar } from "./sb-admin-2"

import jQuery from 'jquery'
window.jQuery = jQuery
window.$ = jQuery
initSideBar(jQuery)

Turbolinks.start()
Rails.start()
channels.createRoom()

function handleChecklistInput(element) {
    $(element).on('input', function(e) {
        console.log(e.target.value);
        $(element).html(e.target.value);
        $('#save_form').trigger('change');
    });
};

function findLastId(children) {
    // let moduleId = splittedFunc(children.attr('id'))
    let childrensChecklistBlock = children.children('.form-group');
    console.log(childrensChecklistBlock)
    childrensChecklistBlock = childrensChecklistBlock.children('textarea')
    console.log(childrensChecklistBlock)
    let lastId = NaN;
    if (childrensChecklistBlock.length == 0) {
        lastId = 0;
    } else {
        let lastCheckName = childrensChecklistBlock[childrensChecklistBlock.length - 1];


        if (typeof(lastCheckName) === 'undefined') {
            lastId = 0;
        } else {
            // let splittedName = lastCheckName.id.split("[");
            // let elementsCount = splittedName.length;
            // let lastCheck = splittedName[elementsCount - 1].replace(/\]/, '');

            let lastCheck = $(lastCheckName).data('checklist-id')
            console.log(lastCheck);

            lastId = Number(lastCheck);
            lastId = isNaN(lastId) ? 0 : lastId;
        }
    }
    return lastId;
}

document.addEventListener('ready', function() {
    $('div[id^="add_checklist_block"]').each(function() {
        addChecklistBlock($(this).attr('id'), splittedFunc($(this).attr('id')))
    });
})

document.addEventListener('turbo:load', function() {
    setOptionsCharts();
    generateCharts();
    tabsForReleaseChecks();
    fixSelectFiles();

    let currentLocation = window.location.pathname;
    let parsedLocation = currentLocation.split('/').slice(1).join('_');
    let formContext = localStorage.getItem(parsedLocation);

    if (formContext !== null) {
        $('#save_form').replaceWith(formContext);
    };

    let checklistIdPrifix = 'checklist[modules]'
    $(`textarea[id^='${checklistIdPrifix}']`).each(function() {
        handleChecklistInput($(this));
    });


    $('div[id^="add_checklist_block"]').each(function() {
        addChecklistBlock($(this).attr('id'), splittedFunc($(this).attr('id')))
    });

    mountModuleBlock();

    $('#save_form').on('change', function() { localStorage.setItem(parsedLocation, $('#save_form').prop('outerHTML')); });
    $('#save_form').on('submit', function() { localStorage.removeItem(parsedLocation); });
});

$('.registration_submit').on("click", function() {
    $('.error_border').removeClass("error_border");
    $('.validation_error').remove();
});

function lastModuleBlockId() {
    let last = $('.checklist_block').children('div[id^="module"]').last();
    console.log(12312321, last)
    let attrId = last.attr('id');
    let splittedId = splittedFunc(attrId)
    return splittedId;
};

function mountModuleBlock() {
    $('#add_module_block').on('click', function() {
        let lastModuleId = lastModuleBlockId();
        let currentModuleId = lastModuleId + 1;
        let checklistBlockId = `add_checklist_block_${currentModuleId}`
        let moduleBlock = genetrateModuleBlock(checklistBlockId, currentModuleId);
        $(moduleBlock).insertAfter($(`#module_${lastModuleId}`))
        addChecklistBlock(checklistBlockId, currentModuleId);
    });
};

function splittedFunc(attr) {
    let splittedId = attr.split('_');
    let splitted = Number(splittedId[splittedId.length - 1]);
    return splitted;
};

function genetrateModuleBlock(id, moduleId) {
    return `
        <div class='module-container col-12 flex-shrink-0 p-2 rounded pl-4 m-1' id='module_${moduleId}'>
            <div class="mb-2">
                <p class="mb-0">${moduleId} модуль.</p>
            </div>
            <div class="form-group mb-2 w-75">
                <input class="form-control form-control-user" placeholder="Введите модуль" type="text" name="checklists[modules][${moduleId}][name]" id="checklists[modules][${moduleId}][name]">
            </div>
            <div class="mb-2 ml-3">
                <p class="mb-0">Список проверок: <i style="color: red">*</i></p>
            </div>
            <div class="btn btn-primary btn-user btn-block w-25" id=${id}>Добавить проверку</div>
        </div>
    `;
};

function addChecklistBlock(id, moduleId) {
    let checkId = `#${id}`
    $(checkId).on('click', function() {
        let checklistBlock = $(`#module_${moduleId}`)

        let lastId = findLastId(checklistBlock)

        let newId = lastId + 1;

        let labelBlock = `<div class="mb-2 ml-3">
            <p class="mb-0">${newId} проверка</p>
        </div>`;
        let checklistName = `checklists[modules][${moduleId}][checklist][${newId}][text]`
        let checklistArea = `
            <div class="form-group mb-2 w-75 ml-5">
                <textarea
                    class="form-control form-control-user"
                    maxlength="5000" style="min-height: 3rem"
                    placeholder="Введите проверку"
                    name=${checklistName}
                    id=${checklistName}
                    data-checklist-id=${newId}></textarea>
            </div>
        `;

        let expectedResultName = `checklists[modules][${moduleId}][checklist][${newId}][expected_result]`

        let expectedResultBlock = `<div class="mb-2 ml-3 expected_result">
            <p class="mb-0">Ожидаемый результат</p>
        </div>`;
        let expectedResultArea = `
            <div class="form-group mb-2 w-75 ml-5">
                <input
                    class="form-control form-control-user"
                    maxlength="5000" style="min-height: 3rem"
                    placeholder="Введите ожидаемый результат"
                    name=${expectedResultName}
                    id=${expectedResultName}
                    data-checklist-id=${newId}></input>
            </div>
        `;

        $(labelBlock + checklistArea + expectedResultBlock + expectedResultArea).insertBefore(`#add_checklist_block_${moduleId}`);
        $('#save_form').trigger('change')

        let checklistTextField = document.getElementById(checklistName)
        handleChecklistInput(checklistTextField)
    });
};

function setOptionsCharts() {
    _Highcharts.setOptions({
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

    _Highcharts.stats_charts_config = () => {
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
}

function generateCharts() {
    $('div[id^="add_chart_block"]').on('click', function() {
        let releaseId = splittedFunc($(this).attr('id'))

        let data = generateChartsData()

        let cfg = _Highcharts.stats_charts_config()
        let selector = `pie_chart_${releaseId}_container`
        let id = `#${selector}`
        console.log(id)
        if ($(id).length > 0) {
            cfg['chart']['renderTo'] = selector
            cfg['chart']['type'] = 'pie'
            let chart = new _Highcharts.Chart(cfg);
            chart.showLoading();
            $.ajax(`/releases/${releaseId}/get_chart_data`, {
                data: data,
                success: function(data) {
                    console.log(data)
                    chart.hideLoading()
                    data.forEach(function(s) {
                        chart.addSeries(s)
                    })
                },
                error: function() {
                    console.log(err)
                }
            });
        }
    })
};

function generateChartsData() {
    let data = {};
    let elements = $("input[id^='check']:checked")
    elements.each(function() {
        let type = splitted($(this).attr('id'))
        let testCaseId = $(this).data('test-case-id');
        if (typeof(data['test_cases']) == 'undefined') {
            data['test_cases'] = {}
        }
        data['test_cases'][testCaseId] = type
    });

    return data;
}

function splitted(attr) {
    let splittedId = attr.split('_');
    let splitted = splittedId[splittedId.length - 1];
    return splitted;
};

function tabsForReleaseChecks() {
    let elements = $("input[id^='check']")
    elements.each(function() {
        let type = splitted($(this).attr('id'))
        let releaseId = $(this).data('release-id');
        let testCaseId = $(this).data('test-case-id');
        let selector = ''
        $(this).on('click', function() {
            console.log(type, releaseId, testCaseId)
            if (type === 'completed') {
                selector = `input[data-release-id="${releaseId}"][id$="uncompleted"][data-test-case-id="${testCaseId}"]`
            } else {
                selector = `input[data-release-id="${releaseId}"][id$="completed"][data-test-case-id="${testCaseId}"]`
            }
            console.log(selector)
            if ($(selector).prop('checked')) {
                $(selector).prop('checked', false)
            };

            if (!$(this).prop('checked')) {
                $(this).prop('checked', true)
            };
            console.log($(this).prop('checked'))
        });
    });
};

function fixSelectFiles() {
    let data = new FormData($('form[id^="bugreports"]')[0]);
    $('#customFile').on('change', function() {
        let filesNames = [];
        let files = this.files
        if (files.length > 0) {
            $.each(files, function(id, file) {
                filesNames.push(file.name)
                data.append(`attachments[${id}]`, file)
            });
            for (const pair of data.entries()) { console.log(pair[0], pair[1]) }
            $('.custom-file-label').html(filesNames.join(', '))
        } else {
            $('.custom-file-label').html('Выберите файл')
        }
    });

    let path = undefined;
    let method = undefined;

    if (typeof(bugreport_id) === 'undefined') {
        path = '/bugreports';
        method = 'POST';
    } else {
        path = `/bugreports/${bugreport_id}`;
        method = 'PUT';
    }

    $('#save_bugreports').on("click", function() {
        data = new FormData($('form[id^="bugreports"]')[0]);
        $.ajax(path, {
            method: method,
            mimeType: 'multipart/form-data',
            cache: false,
            processData: false,
            contentType: false,
            data: data,
            success: function(data) {
                let parsedData = JSON.parse(data);
                let bugreportId = parsedData["bugreport"];
                window.location.replace(`/bugreports/${bugreportId}`);
            },
            error: function(err) {
                console.log(err);
            }
        })
    })
}