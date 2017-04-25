#
# * Generated on 2014-03-14
# * generator-assemble v0.4.10
# * https://github.com/assemble/generator-assemble
# *
# * Copyright (c) 2014 Hariadi Hinta
# * Licensed under the MIT license.
# 
"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# '<%= config.src %>/templates/pages/{,*/}*.hbs'
# use this if you want to match all subfolders:
# '<%= config.src %>/templates/pages/**/*.hbs'


module.exports = (grunt) ->
	require("time-grunt") grunt
	
	# Project configuration.
	grunt.initConfig
		config:
			src: "./src"
			dist: "./dist"

		watch:
			assemble:
				files: ["<%= config.src %>/templates/{,*/}*.*", "<%= config.src %>/data/{,*/}*"]
				tasks: ["jsonmin", "assemble"]

			livereload:
				options:
					livereload: "<%= connect.options.livereload %>"
				files: [
					"<%= config.dist %>/assets/{,*/}*.css"
					"<%= config.dist %>/{,*/}*.html"
					"<%= config.dist %>/assets/{,*/}*.js"
					"<%= config.dist %>/assets/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
				]
			coffee:
				files: ["<%= config.src %>/coffee/*.coffee"]
				tasks: ["coffee", "browserify", "uglify:dev"]
			stylus:
				files: ["<%= config.src %>/stylus/*.styl"]
				tasks: ["stylus"]

		connect:
			options:
				port: 9000
				livereload: 35729
				# change this to '0.0.0.0' to access the server from outside
				hostname: "localhost"

			livereload:
				options:
					open: true
					base: ["<%= config.dist %>"]

		coffee:
			app:
				options: bare: true
				expand: true
				cwd: "<%= config.src %>/coffee/"
				src: ["**/*.coffee"]
				dest: "<%= config.src %>/js/"
				ext: ".js"

		browserify:
			app:
				files: "<%= config.dist %>/assets/js/main.js": ["<%= config.src %>/js/app.js"]
				options: 
					browserifyOptions: paths: ["<%= config.src %>/js/"]
		uglify:
			dev:
				options:
					beautify: true
					compress: false
					mangle: false
				files: [
					src: ["<%= config.dist %>/assets/js/main.js"]
					dest: "<%= config.dist %>/assets/js/main.min.js"
				]
			app:
				options:
					compress: true
					mangle: true
				files: [
					src: ["<%= config.dist %>/assets/js/main.js"]
					dest: "<%= config.dist %>/assets/js/main.min.js"
				]
		jsonmin:
			app:
				files:
					"<%= config.src %>/data/portfolio.min.json": "<%= config.src %>/data/portfolio.json"
		stylus:
			options:
				compress: false
			compile:
				files:
					"<%= config.dist %>/assets/css/main.css": "<%= config.src %>/stylus/style.styl"
		postcss:
			options:
				processors: [
					require('autoprefixer')(browsers: 'last 2 versions')
					require('cssnano')()
				]
			app: src: '<%= config.dist %>/assets/css/main.css'

		assemble:
			options:
				flatten: true
				assets: "<%= config.dist %>/assets"
				helpers: ["handlebars-inline"]
				layout: "<%= config.src %>/templates/layouts/layout.hbs"
				data: "<%= config.src %>/data/*.{json,yml}"
				partials: ["<%= config.src %>/templates/partials/*.hbs", "<%= config.src %>/data/portfolio.json"]
			pages:
				files:
					"<%= config.dist %>/": ["<%= config.src %>/templates/pages/*.hbs"]
			dev:
				options:
					layout: "<%= config.src %>/templates/layouts/layout.dev.hbs"
				files:
					"<%= config.dist %>/dev.html": ["<%= config.src %>/templates/pages/index.hbs"]
	
		# Before generating any new files,
		# remove any previously-created files.
		clean: ["<%= config.dist %>/**/*.{html,css,js}"]

	grunt.loadNpmTasks "grunt-assemble"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-connect"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-stylus"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-uglify"
	grunt.loadNpmTasks "grunt-jsonmin"
	grunt.loadNpmTasks 'grunt-browserify'
	grunt.loadNpmTasks 'grunt-postcss'

	grunt.registerTask "server", [
		"connect:livereload"
		"watch"
	]

	grunt.registerTask "dev", [
		"clean"
		"coffee"
		"browserify"
		"uglify:dev"
		"jsonmin"
		"stylus"
		"postcss"
		"assemble"
		"connect:livereload"
		"watch"
	]

	grunt.registerTask "build", [
		"clean"
		"coffee"
		"browserify"
		"uglify:app"
		"jsonmin"
		"stylus"
		"postcss"
		"assemble"
	]

	# build and preview
	grunt.registerTask "bap", [
		"build"
		"connect:livereload"
	]

	grunt.registerTask "default", ["build"]
	
	return