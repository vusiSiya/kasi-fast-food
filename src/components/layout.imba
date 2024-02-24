
import {
	getTotalPrice,
	getTotalCount,
	getAllItems,
	removeItem
}from "../../api.js"

import "../pages/login.imba"
import "../pages/bought-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"
import http from "http"

css 
	nav d: vflex p: .5em m: 0 0 1em c: white bgc: #75a1a1 fs: large min-width: 100%
	nav > ul p: .5em m: 0 d: flex g: 1em 

	li
		m: 1em .5em fw: bold d: flex place-items: center cursor: pointer
		ai: flex-end g: 0  rd: .375rem 	bgc: #fffff1 @hover:black
		c: black @hover: white

	li > a p: .5em 

	.count bgc: #c51950 p: .25em .5em rd: 100% c: white

tag layout
	prop pathname = document.location.pathname
	prop paramsId = Number(pathname[pathname.length - 1]) || Number(Math.floor(Math.random!*7) + 1)

	prop items = getAllItems()

	def getBoughtItems
		items.filter do(item) item.count;

	<self>
		<nav [p:1em pos:fixed top:0]>
			<ul>
				<li [c:white]> 
					<a route-to="/bought-items"> 
						"🛒" 
						<span.count> getTotalCount!

				<li.total-price [p:.5em]> "Total: R{getTotalPrice!}"
				<li> <a route-to="/login"> "Login"
				<li> <a route-to="/items"> "Menu Items"
				<li> <a route-to="/items/{paramsId}" @mouseover.log(paramsId)> "Random Item"
		<main[d:vflex mt:10rem]>

			if pathname === "/items/{paramsId}"
				<item-detail route="/items/{paramsId}" itemId=paramsId>

			<login route="/login">
			<menu-items route="/items">
			<bought-items route="/bought-items" boughtItems=getBoughtItems!>

		###
			if pathname ==="/" or pathname ==="/items"
				<menu-items>

			else if pathname === "/bought-items"
				<bought-items items=getBoughtItems()>

			else if pathname === "/login"
				<login>

			else if pathname === "/items/{getParamsId()}"
				logStuffOut(getParamsId())
				<item-detail itemId=getParamsId()>
				
			else if pathname === "/login"
				<login>
		###

			
			
			

