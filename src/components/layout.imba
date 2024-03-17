
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
		ai: center g: 0  rd: .28rem 	bgc: #fffff1 c: black 
		@hover bgc: black3 c:white

	li > a p: .25em 

	.count bgc: #c51950 p: .20rem .5rem rd: 100% c: white

tag layout
	prop pathname 
	prop paramsId
	<self>
		<nav>
			<ul>
				<li> 
					<a route-to="/bought-items" [d:flex ai:center g:.25em] > 
						<i.fa-solid .fa-cart-shopping>
						<span.count> getTotalCount!
				<li> <a route-to="login"> "Login"
				<li> <a route-to="items"> "Menu Items"
		<main[d:vflex mt:7.5rem]>
			<slot>


			
			
			

