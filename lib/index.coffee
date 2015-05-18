
exports.Settings = ->
	title: "Spark game"
	theme: "clean"
	lib:   "ui"

exports.Modules = ->
	width  = 375
	height = 667
	box    = width / 5
	top    = 22
	bottom = 44
	swipe  = 22
	pic_top    = top + box
	pic_height = height - (pic_top + bottom)
	layout: 
		jade: ['+chosen', '+yield', '+nav']
		head: ["meta(name='viewport' content='width=device-width initial-scale=1.0, user-scalable=no')"]
	login:
		router: path: '/'
		jade: 'button#facebook-login(class="btn btn-default")': 'login with facebook'
		onServerStartup: ->
			ServiceConfiguration.configurations.remove service: 'facebook'
			ServiceConfiguration.configurations.insert
			    service: 'facebook'
	    		appId:  Settings.facebook.oauth.client_id
	    		secret: Settings.facebook.oauth.secret			
		events:
			'click #facebook-login': -> Meteor.loginWithFacebook()
			'click #logout': -> Meteor.logout()
	chat:
		router: path: 'chat'
		jade: 
			wrapper0:
				container0: 
					'each chats': line0: '{{text}}'
					photo0: 'img#[image0](src="spark1.jpg")': ' '
				'input#[input0](type="text")': ''
		absurd:
			container0: position: 'fixed', bottom: bottom * 2
			line0:      display: 'block'
			input0:     position: 'fixed', bottom: bottom, width: width, height: bottom
			image0:	    width: 'inherit'
			photo0:     position: 'fixed', bottom: bottom + 5, right: 5, width: 100
		events: ->
			'keypress #[input0]': (e) =>
				if e.keyCode == 13 and text = $(@id 'input0').val()
					$(@id 'input0').val ''
					Meteor.call 'says', 'isaac', text 
		collections: 'Chats'
		helpers: chats: -> db.Chats.find {}
		methods: says: (id, text) -> db.Chats.insert id: id, text: text

	home:
		router: path: 'home'
		jade: 
			'#front-container':
				'img(id="front-pic" src="spark1.jpg")': ''
			'img(id="back-pic"  src="{{back_pic}}")'  : ''		
		absurd: 
			'#front-container': position: 'fixed', width: width, height: pic_height, top: pic_top, background: 'white', zIndex: 1000, overflowY: 'hidden'
			'#front-pic': position: 'fixed', width: 'inherit'
			'#back-pic':  position: 'fixed', width: width, top: pic_top, zIndex: -100
		helpers:
			back_pic: -> 'spark' + (Session.get('index') + 1).toString() + '.jpg'
		onStartup: ->  
			Session.set 'index', 1
			Session.set 'chosen-index', 0
		onRendered: -> 
			$front = $ '#front-container'
			$pic   = $ '#front-pic'
			forward = (i) ->
				$front.hide()
				$pic.attr('src', 'spark' + i + '.jpg')
				x.timeout 100, -> 
					$front.css(top: pic_top, height: pic_height, left: 0, width: width, background: 'white').show()
					Session.set 'index', i
			$front.draggable(axis:'y').on 'touchend', ($e) ->
				if $e.target.y > pic_top + swipe
					$front.animate top: '+=2500', 500, -> forward Session.get('index') + 1
				else if $e.target.y < pic_top - swipe
					index = Session.get('index')
					chosen_index = Session.get('chosen-index')
					Session.set 'chosen-index', chosen_index + 1
					$front.animate top: top, width: box, height: box, left: box * chosen_index, 500, ->
						$('#chosen-box-' + chosen_index.toString()).attr 'src', 'spark' + index + '.jpg'
						forward index + 1
				else
					$front.animate top: pic_top, backgroundColor: 'white', 200
			$front.on 'touchstart', ($e) -> $front.animate backgroundColor: 'transparent', 200

	chosenbox:
		jade: 
			'.chosen-container(style="left:{{left}}px;")': 
				'img(class="chosen-box" id="chosen-box-{{id}}") ': ''
		absurd:
			_chosenContainer: position: 'fixed', zIndex: 200, top: top, border: 3, width: box, height: box, overflowY: 'hidden'
			_chosenBox:  width: box, background: 'rgba(255, 0, 0, 0.7)'

	chosen:
		jade: $chosen: 'each chosen': '+chosenbox': ''
		helpers: chosen: [0..4].map (i) -> id: i, left: box * i

	settings:
		router: path: 'setting'
		jade: h2: 'Settings'

	menu_list:
		jade: li: 'a.main-menu(id="menu-toggle-{{id}}" href="{{path}}"):': 'i.fa(class="fa-{{icon}}")'
		helpers: path: -> ['/chat', '/home', '/setting'][@id]
		absurd: 
			'#main-menu ul li': display: 'inline-block', width: bottom * 1.5
			'.main-menu': display: 'inline-block', width: bottom * 1.5, color: 'white', padding: 12, textAlign: 'center'
			'.main-menu:hover': backgroundColor: 'rgba(255, 128, 128, 1)'
			'.main-menu:focus': backgroundColor: 'white'

	nav:
		jade: '#main-menu': ul: 'each menu': '+menu_list': ''
		helpers: menu: -> [{id:0, icon: 'comment'}, {id:1, icon: 'bolt'}, {id:2, icon: 'gear'}]			
		absurd: 
			'#main-menu': position: 'fixed', left:0, bottom: 0, width: '100%', height: bottom, background: 'rgba(255, 0, 0, 1)'
			'#main-menu ul': listStyleType: 'none', margin: 0, marginLeft: 40