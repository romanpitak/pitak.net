# Sidebar manipulation

    do (document) ->

Find the elements

        sidebar = document.getElementById 'sidebar'
        wrap = document.getElementById 'wrap'
        toggle = document.getElementById 'sidebar-toggle'
        checkbox = toggle.querySelector 'input'

Preset checkbox state. Without this, the first click does not fire change state.

        checkbox.checked = false

When the sidebar is visible, any click outside of the sidebar goes to the checkbox.

This function is bound to the `click` event listener in `showSidebar()`
and unbound in `hideSidebar()`

        onPageClick = (e) ->
            target = e.target
            return if ! checkbox.checked
            return if sidebar.contains target
            return if target == checkbox
            return if target == toggle
            checkbox.click()

Show the sidebar

        showSidebar = ->
            sidebar.style.left = '0px'
            wrap.style.marginLeft = '280px'
            toggle.style.left = '300px' # 280 + 20
            toggle.className = 'active'
            document.addEventListener 'click', onPageClick, false

Hide the sidebar

        hideSidebar = ->
            sidebar.style.left = '-280px'
            wrap.style.marginLeft = '0px'
            toggle.className = ''
            toggle.style.left = '20px'
            document.removeEventListener 'click', onPageClick, false

Event listener for checkbox

        onChangeCheckbox = (event) ->
            if event.target.checked
                do showSidebar
            else
                do hideSidebar

Bind the checkbox event listener

        checkbox.addEventListener 'change', onChangeCheckbox, false
