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
    $(element).on('input', function (e) {
        console.log(e.target.value);
        $(element).html(e.target.value);
        $('#save_form').trigger('change');
    });
};

document.addEventListener('turbo:load', () => {

    let currentLocation = window.location.pathname;
    let parsedLocation = currentLocation.split('/').slice(1).join('_');

    let formContext = localStorage.getItem(parsedLocation);

    if (formContext !== null) {
        console.log(formContext)
        $('#save_form').replaceWith(formContext)
    }

    let checklistIdPrifix = 'checklist[checklists]'
    $(`textarea[id^='${checklistIdPrifix}']`).each(function () {
        handleChecklistInput($(this));
    });

    $("#add_checklist_block").on('click', function () {
        let checklistBlock = $('.checklist_block');

        let childrensChecklistBlock = checklistBlock.children();
        let lastId = NaN;
        if (childrensChecklistBlock.length == 1) {
            lastId = 0;
        } else {
            let lastCheckName = childrensChecklistBlock[childrensChecklistBlock.length - 1].children[0].name;

            if (typeof (lastCheckName) === 'undefined') {
                lastId = 0;
            } else {
                let splittedName = lastCheckName.split("[");
                let elementsCount = splittedName.length;
                let lastCheck = splittedName[elementsCount - 1].replace(/\]/, '');

                lastId = Number(lastCheck);
                lastId = isNaN(lastId) ? 0 : lastId;
            }
        }

        let newId = lastId + 1;
        let labelBlock = `<div class="col-sm-3"><p class="mb-0">${newId} проверка<i style="color: red">*</i></p></div>`;
        let checklistName = `checklist[checklists][${newId}]`
        let checklistArea = `
            <div class="form-group col-sm-9">
                <textarea
                    class="form-control form-control-user"
                    maxlength="5000" style="min-height: 3rem"
                    placeholder="Введите список проверок"
                    name=${checklistName}
                    id=${checklistName}></textarea>
            </div>
        `;
        checklistBlock.append(labelBlock + checklistArea);
        $('#save_form').trigger('change')

        let checklistTextField = document.getElementById(checklistName)
        handleChecklistInput(checklistTextField)
    });

    // save forms to local storage
    $('#save_form').on('change', function () { localStorage.setItem(parsedLocation, $('#save_form').prop('outerHTML')); });

    $('#save_form').on('submit', function () { localStorage.removeItem(parsedLocation); });
});

