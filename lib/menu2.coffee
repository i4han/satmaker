
widget_id = ['592037597326610433', '592037985006190592', '592038136508649472', '592038331401113600', '592038497021612032', '592038669051006976', '592038775259148291', '592038880963989504', '592040098918633472', '592040195505041408',
             '592040339747147776', '592040484647763968', '592040609797378048', '592040736729604096', '592040875204546562', '592040970507591680', '592041067551166464', '592041181657178113', '592041307712819202', '592095299209826306',
             '592095536359964672', '592095824693170176', '592095931647963137', '592096105573191680', '592096544460902400', '592098504505315329', '592098601666392064', '592098703013388288', '592098801491410944', '592098902834159617',
             '592098990222512128', '592099242128248832', '592099326618308608', '592099410697289728', '592099582147842048',
             '592358731561603072', '592358961698906112', '592359090375921664', '592359443020447744', '592359535437742080', '592359622385602563']

exports.menu =

    menu_list:
        jade: li:'a(href="{{path}}" id="{{id}}")': '{{label}}'
        helpers: 
            path:  -> Router.path @name 
            label: -> Module[@name].label
            
    navbar:                                    # seperate menu_list and navbar
        jade: ->
            """
            .navbar.navbar-default.navbar-#{@Theme.navbar.style}
                .navbar-left 
                    ul.nav.navbar-nav
                        li: a#menu-toggle: i.fa.fa-bars
                        +logo
                        li: #space &nbsp;
                        li: #site-title
                .navbar-right
                    ul.nav.navbar-nav
                        li: a#twitter-toggle: i.fa.fa-twitter
            """
        styl: ->
            '.navbar': backgroundColor:@Theme.navbar.backgroundColor
            '.navbar-fixed-top': border: 0
        events:
            'click #twitter-toggle': (event) -> 
                $("#wrapper").toggleClass "twitter"
                $("#twitter-wrapper").toggleClass "open"
            'click #menu-toggle': (event) -> $("#wrapper").toggleClass "menu" # event.preventDefault()                
            'click #navbar-menu': (event) ->
                menu_selected = event.target.innerText.toLowerCase()
                $('#listen-to-menu-change').trigger 'custom', [menu_selected]

        styl$: ->
            T = @Theme.navbar 
            '#space': width: 100, padding: 15
            '#menu-toggle': width: 50
            '#twitter-toggle': width: 50, marginRight: 13, textAligh: 'center'
            '#login-buttons': 
                height: 50, width: T.login.width, textAligh: 'center'
                padding: 15
            'li#login-dropdown-list': 
                width: T.login.width, height: T.height, display: 'table-cell'
                textAlign: 'center', verticalAlign: 'middle'
            '.navbar-default .navbar-nav > li > a:focus': backgroundColor: T.focus.backgroundColor
            '#site-title': 
                color: T.text.color, padding: 15, marginLeft: 5, fontSize: 14
            '.navbar-default .navbar-nav > li > a': color: T.text.color
            '.navbar-left > ul > li > a': width: T.text.width, textAlign: 'center'
            '.navbar-right > ul > li:hover, .navbar-left > ul > li:hover, .navbar-nav > li > a:hover':
                textDecoration: 'none', color: T.hover.color, backgroundColor: T.hover.backgroundColor
            '.dropdown-toggle > i.fa-chevron-down': paddingLeft: 4
            '#navbar-menu:focus': color: 'black', backgroundColor: T.focus.backgroundColor
            '#twitter-toggle:focus': color: 'black', backgroundColor: T.focus.backgroundColor
    sidebar: 
        absurd: -> 
            sidebar_width = 260
            twitter_width = 300
            '#wrapper': 
                paddingTop: 50, paddingLeft: 0, paddingRight: 0, marginRight: 0, WebkitTransition: 'all 0.8s ease', 
                '@media(min-width:768px)': paddingLeft: sidebar_width, height: '100%'
                #-webkit-transition: all 0.5s ease;
                #-moz-transition: all 0.5s ease;
                #-o-transition: all 0.5s ease;  
            '#wrapper.menu': paddingLeft: sidebar_width, '@media(min-width:768px)': paddingLeft: 0
            '#wrapper.twitter': paddingRight: 0, marginRight: twitter_width
            '#twitter-wrapper': 
                zIndex: 1000, position: 'fixed', right: 0, top: 50, width: twitter_width, height: '100%', paddingTop: 0
                marginRight: -twitter_width, overflowY: 'auto', background: 'rgba(200, 200, 200, 0.6)', WebkitTransition: 'all 0.8s ease'
            '#twitter-wrapper.open': 
                marginRight: 0     
            '#sidebar-wrapper': 
                display: 'flex', zIndex: 1000, position: 'fixed', width: sidebar_width, height: '100%', paddingTop: 50
                marginLeft: -sidebar_width, overflowY: 'auto', background: 'rgba(200, 200, 200, 0.6)', WebkitTransition: 'all 0.8s ease'
                #'@media(min-width:768px)': width: sidebar_width
            '#wrapper.menu #sidebar-wrapper': marginLeft: -sidebar_width
            '#content-wrapper': width: '100%', padding: 15
            '#wrapper.menu #content-wrapper': 
                position: 'absolute', marginRight: -sidebar_width
                '@media(min-width:768px)': position: 'relative', marginRight: 0
            '.sidebar-nav': position: 'absolute', top: 40, width: sidebar_width, margin: 0, padding: 0, listStyle: 'none'
            '.sidebar-nav li': textIndent: 20, lineHeight: 40
            '.sidebar-nav li a:hover': textDecoration: 'none', color: '#000', backgroundColor: '#e8e8e8'
            '.sidebar-nav li a:active, .sidebar-nav li a:focus': textDecoration: 'none', color: '#000', backgroundColor: '#ddd'
            '.sidebar-nav > .sidebar-brand': height: 65, fontSize: 18, lineHeight: 60
            '.sidebar-nav > .sidebar-brand a': color: '#999'
            '.sidebar-nav > .sidebar-brand a:hover': color: '#fff', background: 'none'
        jade:
            'form#listen-to-menu-change': ''
            '#sidebar-wrapper':
                '#sidebar-top': ''
                'ul.sidebar-nav': 
                    'each sites':
                        '+side_menu_list': ''
                        
        helpers:
            sites: -> db.ConstructionSite.find {}, sort: started: -1




  



