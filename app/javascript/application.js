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

document.addEventListener('turbo:load', () => {
    $("#add_checklist_block").on('click', function () {
        let checklistBlock = $('.checklist_block');

        let childrensChecklistBlock = checklistBlock.children()
        let lastId = NaN
        if (childrensChecklistBlock.length == 1) {
            lastId = 0
        } else {
            let lastCheckName = childrensChecklistBlock[childrensChecklistBlock.length - 1].children[0].name

            let splittedName = lastCheckName.split("[")
            let elementsCount = splittedName.length
            let lastCheck = splittedName[elementsCount - 1].replace(/\]/, '')
            console.log(lastCheck)

            lastId = Number(lastCheck)
            lastId = isNaN(lastId) ? 0 : lastId
        }


        console.log(lastId)

        let newId = lastId + 1
        let labelBlock = `<div class="col-sm-3"><p class="mb-0">${newId} проверка<i style="color: red">*</i></p></div>`;
        let checklistArea = `
            <div class="form-group col-sm-9">
                <textarea
                    class="form-control form-control-user"
                    maxlength="5000" style="min-height: 3rem"
                    placeholder="Введите список проверок"
                    name="checklist[checklists][${newId}]"
                    id="checklist_checklist">
                </textarea>
            </div>
        `;
        checklistBlock.append(labelBlock + checklistArea)
    });
})