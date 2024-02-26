
import {
	getTotalPrice,
	getTotalCount,
} from "../../api.js"

import "../pages/login.imba"
import "../pages/bought-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"

css 
	nav d: vflex m: 0 0 .8em c: white p: 0.5em 0 bgc: #75a1a1
		min-width: 100% pos:fixed top:0
		
	nav > ul m: 0 d: flex g: .6em 

	li
		m: 1em .5em fw: bold d: flex place-items: center cursor: pointer
		ai: flex-end g: 0  rd: .28rem 	bgc: #fffff1 @hover:black
		c: black @hover: white

	li > a p: .5em 

	.count bgc: #c51950 p: .25em .5em rd: 100% c: white

tag layout
	prop pathname 
	prop paramsId
	<self>
		<nav>
			<ul>
				<li [c:white]> 
					<a route-to="/bought-items"> 
						"🛒" 
						<span.count> getTotalCount!
				<li> <a route-to="login"> "Login"
				<li> <a route-to="items"> "Menu Items"
		<main[d:vflex mt:7.5rem]>
			<slot>


			
			
			

