// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import Turbolinks from 'turbolinks'
import "bootstrap"
import '@popperjs/core'
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
            let splittedName = lastCheckName.id.split("[");
            console.log(splittedName);
            let elementsCount = splittedName.length;
            let lastCheck = splittedName[elementsCount - 1].replace(/\]/, '');

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
            <div class="btn btn-primary btn-user btn-block" id=${id}>Добавить проверки</div>
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
        let checklistName = `checklists[modules][${moduleId}][checklist][${newId}]`
        let checklistArea = `
            <div class="form-group mb-2 w-75 ml-5">
                <textarea
                    class="form-control form-control-user"
                    maxlength="5000" style="min-height: 3rem"
                    placeholder="Введите список проверок"
                    name=${checklistName}
                    id=${checklistName}></textarea>
            </div>
        `;
        $(labelBlock + checklistArea).insertBefore(`#add_checklist_block_${moduleId}`);
        $('#save_form').trigger('change')

        let checklistTextField = document.getElementById(checklistName)
        handleChecklistInput(checklistTextField)
    });
};