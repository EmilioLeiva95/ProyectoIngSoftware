<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${ not empty locale}">
	<fmt:setLocale value="${ locale }" />
</c:if>
<fmt:bundle basename="com.persistence.resourceBundle.MessagesResources">
<c:if test="${ not empty productsEstado.enlaceDetalle}">
	<c:set var="detalle" value="${productsEstado.enlaceDetalle}"/>	
	<c:set var="detalleEnllavador" value="${detalle.enllavador}"/>
</c:if>	

<c:set var="nombre" value="products"/>
<c:set var="ubicacion" value="filtrar"/>
<c:set var="primerCampo" value="categoryMin"/>
<%@ include file="/WEB-INF/global/jsp/jq-header.jsp" %>

<form  name="mainForm" id="mainForm" action="${NewtPageRenderData.actionUrl}" method="post">
<div class="breadCrumbHolder module" style="margin-bottom: 3px;">
<div id="breadcrumb" class="breadCrumb module ui-widget ui-widget-content" style="width: 99%;">
<ul>
	<li><a href="${ctx}/inicio/blank/ria"> <fmt:message key="globales.bc.etiqueta.home" /> </a> </li>
<c:if test="${ not empty ubicacionAplicacion.ruta }">
	<input type="hidden" name="idUbicacionAplicacionActual" id="idUbicacionAplicacionActual" value="${ ubicacionAplicacion.idUbicacionAplicacionActual }"/>
	<c:forEach items="${ ubicacionAplicacion.ruta }" var="ub">
		<li><a href="javascript: doSubmitBreadcrumb('<c:out value="${ ub.submit }"/>', '<c:out value="${ ub.id }"/>')"><c:out value="${ ub.label }" escapeXml="false" /></a>  </li> 
	</c:forEach>			
</c:if>
	<li><fmt:message key="products.bc.etiqueta.filtrar" /></li>
</ul>
</div>
	<input type="hidden" name="id_ubicacion_retorno" id="id_ubicacion_retorno" value=""/>
</div>
<c:if test="${ not empty detalle.cabecera}">
    <jsp:include page="/WEB-INF/jsp/${detalle.cabecera.locacion}/jq/cabecera.jsp" />
</c:if>	
<div id="mainContent">
	
    <div id="iTitle" class="ui-state-default ui-widget-content ui-corner-all">
    	<fmt:message key="products.formulario.etiqueta.filtrar.titulo"/>
    </div>
	
	<div id="iProcessing" style="visibility: hidden" align="center">
    	<img src="${ctx}/include/images/design/processing_request.gif"></img>
    </div>
	
	<input type="hidden" id="pageLoc" name="pageLoc" value="filtrar"/>
	<input type="hidden" id="primerCampo" name="primerCampo" value="categoryMin"/>
    <input type="hidden" id="eag" name="eag" value="${eag}"/>
    <input type="hidden" id="movimientoPagina" name="movimientoPagina"/>
    <input type="hidden" id="columna" name="columna"/>
    <input type="hidden" id="fenixf31seguridad" name="fenixf31seguridad" value="<c:out value='${fenixf31seguridad}' />" />
	<c:if test="${not empty scrollTo }">
    <input type="hidden" id="scrollSmooth" value="<c:out value='${scrollTo}' />" />
    </c:if>
	<!-- valores de llaves -->


<!-- mensajes de error-->
<c:if test="${mensajesUsuario.erroresGlobales}">
<div id="iError">
	<b class="ui-round-top"> 
	<b class="ui-line-one"></b><b class="ui-line-two"></b><b class="ui-line-three"></b><b class="ui-line-four"></b> 
    </b> 
  	<table>
     	<tr>
       		<td>
         	<ol>
	     	<c:forEach items="${mensajesUsuario.mensajesDeError}" var="mensaje">
	        	<li><c:out value="${mensaje}" escapeXml="false"/></li>
	     	</c:forEach>
	     	</ol>
       		</td>
     	</tr>
  	</table>
  	<b class="ui-round-bottom"> 
	<b class="ui-line-four"></b><b class="ui-line-three"></b><b class="ui-line-two"></b><b class="ui-line-one"></b> 
  	</b> 
</div>
</c:if>

<div id="action-buttons">
<div id="action-bar">
	<button tabindex="13" id="btnAplicarFiltro" type="button" name="Filtrar" onClick="doSubmit<c:if test="${ not empty detalle.cabecera || not empty esAsync}">Async</c:if>('products/filtrarEjecutar');"><fmt:message key="globales.filtro.boton.aplicarFiltro"/></button>
	<button tabindex="14" id="btnLimpiar" type="button" name="Limpiar" onClick="limpiarCampos('mainForm');"><fmt:message key="globales.filtro.boton.limpiar"/></button>
	<button tabindex="15" id="btnCancelar" type="button" name="Cancelar" onClick="doSubmit<c:if test="${ not empty detalle.cabecera || not empty esAsync}">Async</c:if>('products/cancelarFiltrar');"><fmt:message key="globales.filtro.boton.cancelar"/></button>
</div>
</div>
<br />

<!-- datos de formulario -->
<div class="ui-widget ui-widget-content ui-corner-all" style="width: 99%">
		<div id="formInputHeader" class="ui-widget ui-widget-header ui-corner-top" style="padding-left: 5px;"> 
			<fmt:message key="products.formulario.etiqueta.filtrar.titulo"/> 
		</div>
		<div style="display: inline;" id="formInput">
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['category']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.Category"/>
			</span>
			<span class="forminput" style="display: inline">
		        <input tabindex="2" alt="integerMin" type="text" id="categoryMin" name="categoryMin" value="${productsFiltro['categoryMin']}"/>
			    &nbsp;<fmt:message key="globales.filtro.etiqueta.rangoHasta"/>&nbsp;
			    <input tabindex="2" alt="integerMax" type="text" id="categoryMax" name="categoryMax" value="${productsFiltro['categoryMax']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['category'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['title']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.Title"/>
			</span>
			<span class="forminput" style="display: inline">
	            <input tabindex="3" type="text" id="title" name="title" value="${productsFiltro['title']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['title'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['actor']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.Actor"/>
			</span>
			<span class="forminput" style="display: inline">
	            <input tabindex="4" type="text" id="actor" name="actor" value="${productsFiltro['actor']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['actor'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['price']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.Price"/>
			</span>
			<span class="forminput" style="display: inline">
	            <input tabindex="5" alt="numericMin" type="text" id="priceMin" name="priceMin" value="${productsFiltro['priceMin']}"/>
				&nbsp;<fmt:message key="globales.filtro.etiqueta.rangoHasta"/>&nbsp;
				<input tabindex="5" alt="numericMax" type="text" id="priceMax" name="priceMax" value="${productsFiltro['priceMax']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['price'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['special']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.Special"/>
			</span>
			<span class="forminput" style="display: inline">
		        <input tabindex="6" alt="integerMin" type="text" id="specialMin" name="specialMin" value="${productsFiltro['specialMin']}"/>
			    &nbsp;<fmt:message key="globales.filtro.etiqueta.rangoHasta"/>&nbsp;
			    <input tabindex="6" alt="integerMax" type="text" id="specialMax" name="specialMax" value="${productsFiltro['specialMax']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['special'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
<c:if test="${ empty detalleEnllavador.valoresEnllavador or empty detalleEnllavador.valoresEnllavador['commonProdId']}">
		<div class="row" >
			<span class="label"> 
				<fmt:message key="products.filtro.etiqueta.CommonProdId"/>
			</span>
			<span class="forminput" style="display: inline">
		        <input tabindex="7" alt="integerMin" type="text" id="commonProdIdMin" name="commonProdIdMin" value="${productsFiltro['commonProdIdMin']}"/>
			    &nbsp;<fmt:message key="globales.filtro.etiqueta.rangoHasta"/>&nbsp;
			    <input tabindex="7" alt="integerMax" type="text" id="commonProdIdMax" name="commonProdIdMax" value="${productsFiltro['commonProdIdMax']}"/>
			</span>
			<c:forEach items="${mensajesUsuario.mapaDeErroresEnPropiedades['commonProdId'].mensaje}" var="mensaje">
			<span style="font-size: 90%;" class="ui-state-error"> <c:out value="${mensaje}" escapeXml="false"/> </span>
			</c:forEach>
		</div>	
</c:if>
</div>	


</div>
</div>
</form>

<%@ include file="/WEB-INF/global/jsp/jq-footer.jsp" %>
</fmt:bundle>
</body>