<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>productInput</title>
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    
    <style>
    body[data-theme="dark"] .select2-container--default .select2-selection--single,
		body[data-theme="dark"] .select2-container--default .select2-selection--multiple,
		body[data-theme="dark"] .select2-container--classic .select2-selection--single,
		body[data-theme="dark"] .dtp>.dtp-content {
		    background-color: #272b34;
	}
    .form-control {
		    display: block;
		    width: 100%;
		    padding: 0.375rem 0.75rem;
		    font-size: 0.875rem;
		    line-height: 1.5;
		    color: #4F5467;
		    background-color: #fff;
		    background-clip: padding-box;
		    border: 1px solid #e9ecef;
		    border-radius: 2px;
		    -webkit-transition: border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		    transition: border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		    -o-transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
		    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
		    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		}
		
		@media screen and (prefers-reduced-motion: reduce) {
		    .form-control {
		        -webkit-transition: none;
		        -o-transition: none;
		        transition: none;
		    }
		}
		
		.form-control::-ms-expand {
		    background-color: transparent;
		    border: 0;
		}
		
		.form-control:focus {
		    color: #4F5467;
		    background-color: #fff;
		    border-color: rgba(0, 0, 0, 0.25);
		    outline: 0;
		    -webkit-box-shadow: transparent;
		    box-shadow: transparent;
		}
		
		.form-control::-webkit-input-placeholder {
		    color: #6c757d;
		    opacity: 1;
		}
		
		.form-control:-ms-input-placeholder {
		    color: #6c757d;
		    opacity: 1;
		}
		
		.form-control::-ms-input-placeholder {
		    color: #6c757d;
		    opacity: 1;
		}
		
		.form-control::placeholder {
		    color: #6c757d;
		    opacity: 1;
		}
		
		.form-control:disabled,
		.form-control[readonly] {
		    background-color: #e9ecef;
		    opacity: 1;
		}
		
		select.form-control:not([size]):not([multiple]) {
		    height: calc(2.0625rem + 2px);
		}
		
		select.form-control:focus::-ms-value {
		    color: #4F5467;
		    background-color: #fff;
		}
		
		.form-control-file,
		.form-control-range {
		    display: block;
		    width: 100%;
		}
		
		.col-form-label {
		    padding-top: calc(0.375rem + 1px);
		    padding-bottom: calc(0.375rem + 1px);
		    margin-bottom: 0;
		    font-size: inherit;
		    line-height: 1.5;
		}
		
		.col-form-label-lg {
		    padding-top: calc(0.5rem + 1px);
		    padding-bottom: calc(0.5rem + 1px);
		    font-size: 1.09375rem;
		    line-height: 1.5;
		}
		
		.col-form-label-sm {
		    padding-top: calc(0.25rem + 1px);
		    padding-bottom: calc(0.25rem + 1px);
		    font-size: 0.76563rem;
		    line-height: 1.5;
		}
		
		.form-control-plaintext {
		    display: block;
		    width: 100%;
		    padding-top: 0.375rem;
		    padding-bottom: 0.375rem;
		    margin-bottom: 0;
		    line-height: 1.5;
		    color: #3e5569;
		    background-color: transparent;
		    border: solid transparent;
		    border-width: 1px 0;
		}
		
		.form-control-plaintext.form-control-sm,
		.input-group-sm>.form-control-plaintext.form-control,
		.input-group-sm>.input-group-prepend>.form-control-plaintext.input-group-text,
		.input-group-sm>.input-group-append>.form-control-plaintext.input-group-text,
		.input-group-sm>.input-group-prepend>.form-control-plaintext.btn,
		.input-group-sm>.input-group-append>.form-control-plaintext.btn,
		.form-control-plaintext.form-control-lg,
		.input-group-lg>.form-control-plaintext.form-control,
		.input-group-lg>.input-group-prepend>.form-control-plaintext.input-group-text,
		.input-group-lg>.input-group-append>.form-control-plaintext.input-group-text,
		.input-group-lg>.input-group-prepend>.form-control-plaintext.btn,
		.input-group-lg>.input-group-append>.form-control-plaintext.btn {
		    padding-right: 0;
		    padding-left: 0;
		}
		
		.form-control-sm,
		.input-group-sm>.form-control,
		.input-group-sm>.input-group-prepend>.input-group-text,
		.input-group-sm>.input-group-append>.input-group-text,
		.input-group-sm>.input-group-prepend>.btn,
		.input-group-sm>.input-group-append>.btn {
		    padding: 0.25rem 0.5rem;
		    font-size: 0.76563rem;
		    line-height: 1.5;
		    border-radius: 1px;
		}
		
		select.form-control-sm:not([size]):not([multiple]),
		.input-group-sm>select.form-control:not([size]):not([multiple]),
		.input-group-sm>.input-group-prepend>select.input-group-text:not([size]):not([multiple]),
		.input-group-sm>.input-group-append>select.input-group-text:not([size]):not([multiple]),
		.input-group-sm>.input-group-prepend>select.btn:not([size]):not([multiple]),
		.input-group-sm>.input-group-append>select.btn:not([size]):not([multiple]) {
		    height: calc(1.64844rem + 2px);
		}
		
		.form-control-lg,
		.input-group-lg>.form-control,
		.input-group-lg>.input-group-prepend>.input-group-text,
		.input-group-lg>.input-group-append>.input-group-text,
		.input-group-lg>.input-group-prepend>.btn,
		.input-group-lg>.input-group-append>.btn {
		    padding: 0.5rem 1rem;
		    font-size: 1.09375rem;
		    line-height: 1.5;
		    border-radius: 2px;
		}
		
		select.form-control-lg:not([size]):not([multiple]),
		.input-group-lg>select.form-control:not([size]):not([multiple]),
		.input-group-lg>.input-group-prepend>select.input-group-text:not([size]):not([multiple]),
		.input-group-lg>.input-group-append>select.input-group-text:not([size]):not([multiple]),
		.input-group-lg>.input-group-prepend>select.btn:not([size]):not([multiple]),
		.input-group-lg>.input-group-append>select.btn:not([size]):not([multiple]) {
		    height: calc(2.64063rem + 2px);
		}
		
		.form-group {
		    margin-bottom: 1rem;
		}
		
		.form-text {
		    display: block;
		    margin-top: 0.25rem;
		}
		
		.form-row {
		    display: -webkit-box;
		    display: -ms-flexbox;
		    display: flex;
		    -ms-flex-wrap: wrap;
		    flex-wrap: wrap;
		    margin-right: -5px;
		    margin-left: -5px;
		}
		
		.form-row>.col,
		.form-row>[class*="col-"] {
		    padding-right: 5px;
		    padding-left: 5px;
		}
		
		.form-check {
		    position: relative;
		    display: block;
		    padding-left: 1.25rem;
		}
		
		.form-check-input {
		    position: absolute;
		    margin-top: 0.3rem;
		    margin-left: -1.25rem;
		}
		
		.form-check-input:disabled~.form-check-label {
		    color: #a1aab2;
		}
		
		.form-check-label {
		    margin-bottom: 0;
		}
		
		.form-check-inline {
		    display: -webkit-inline-box;
		    display: -ms-inline-flexbox;
		    display: inline-flex;
		    -webkit-box-align: center;
		    -ms-flex-align: center;
		    align-items: center;
		    padding-left: 0;
		    margin-right: 0.75rem;
		}
		
		.form-check-inline .form-check-input {
		    position: static;
		    margin-top: 0;
		    margin-right: 0.3125rem;
		    margin-left: 0;
		}
		
		.valid-feedback {
		    display: none;
		    width: 100%;
		    margin-top: 0.25rem;
		    font-size: 80%;
		    color: #36bea6;
		}
		
		.valid-tooltip {
		    position: absolute;
		    top: 100%;
		    z-index: 5;
		    display: none;
		    max-width: 100%;
		    padding: .5rem;
		    margin-top: .1rem;
		    font-size: .875rem;
		    line-height: 1;
		    color: #fff;
		    background-color: rgba(54, 190, 166, 0.8);
		    border-radius: .2rem;
		}
		
		.was-validated .form-control:valid,
		.form-control.is-valid,
		.was-validated .custom-select:valid,
		.custom-select.is-valid {
		    border-color: #36bea6;
		}
		
		.was-validated .form-control:valid:focus,
		.form-control.is-valid:focus,
		.was-validated .custom-select:valid:focus,
		.custom-select.is-valid:focus {
		    border-color: #36bea6;
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		    box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		}
		
		.was-validated .form-control:valid~.valid-feedback,
		.was-validated .form-control:valid~.valid-tooltip,
		.form-control.is-valid~.valid-feedback,
		.form-control.is-valid~.valid-tooltip,
		.was-validated .custom-select:valid~.valid-feedback,
		.was-validated .custom-select:valid~.valid-tooltip,
		.custom-select.is-valid~.valid-feedback,
		.custom-select.is-valid~.valid-tooltip {
		    display: block;
		}
		
		.was-validated .form-check-input:valid~.form-check-label,
		.form-check-input.is-valid~.form-check-label {
		    color: #36bea6;
		}
		
		.was-validated .form-check-input:valid~.valid-feedback,
		.was-validated .form-check-input:valid~.valid-tooltip,
		.form-check-input.is-valid~.valid-feedback,
		.form-check-input.is-valid~.valid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-control-input:valid~.custom-control-label,
		.custom-control-input.is-valid~.custom-control-label {
		    color: #36bea6;
		}
		
		.was-validated .custom-control-input:valid~.custom-control-label::before,
		.custom-control-input.is-valid~.custom-control-label::before {
		    background-color: #93e0d3;
		}
		
		.was-validated .custom-control-input:valid~.valid-feedback,
		.was-validated .custom-control-input:valid~.valid-tooltip,
		.custom-control-input.is-valid~.valid-feedback,
		.custom-control-input.is-valid~.valid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-control-input:valid:checked~.custom-control-label::before,
		.custom-control-input.is-valid:checked~.custom-control-label::before {
		    background-color: #58cfba;
		}
		
		.was-validated .custom-control-input:valid:focus~.custom-control-label::before,
		.custom-control-input.is-valid:focus~.custom-control-label::before {
		    -webkit-box-shadow: 0 0 0 1px #eef5f9, 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		    box-shadow: 0 0 0 1px #eef5f9, 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		}
		
		.was-validated .custom-file-input:valid~.custom-file-label,
		.custom-file-input.is-valid~.custom-file-label {
		    border-color: #36bea6;
		}
		
		.was-validated .custom-file-input:valid~.custom-file-label::before,
		.custom-file-input.is-valid~.custom-file-label::before {
		    border-color: inherit;
		}
		
		.was-validated .custom-file-input:valid~.valid-feedback,
		.was-validated .custom-file-input:valid~.valid-tooltip,
		.custom-file-input.is-valid~.valid-feedback,
		.custom-file-input.is-valid~.valid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-file-input:valid:focus~.custom-file-label,
		.custom-file-input.is-valid:focus~.custom-file-label {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		    box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.25);
		}
		
		.invalid-feedback {
		    display: none;
		    width: 100%;
		    margin-top: 0.25rem;
		    font-size: 80%;
		    color: #f62d51;
		}
		
		.invalid-tooltip {
		    position: absolute;
		    top: 100%;
		    z-index: 5;
		    display: none;
		    max-width: 100%;
		    padding: .5rem;
		    margin-top: .1rem;
		    font-size: .875rem;
		    line-height: 1;
		    color: #fff;
		    background-color: rgba(246, 45, 81, 0.8);
		    border-radius: .2rem;
		}
		
		.was-validated .form-control:invalid,
		.form-control.is-invalid,
		.was-validated .custom-select:invalid,
		.custom-select.is-invalid {
		    border-color: #f62d51;
		}
		
		.was-validated .form-control:invalid:focus,
		.form-control.is-invalid:focus,
		.was-validated .custom-select:invalid:focus,
		.custom-select.is-invalid:focus {
		    border-color: #f62d51;
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		    box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		}
		
		.was-validated .form-control:invalid~.invalid-feedback,
		.was-validated .form-control:invalid~.invalid-tooltip,
		.form-control.is-invalid~.invalid-feedback,
		.form-control.is-invalid~.invalid-tooltip,
		.was-validated .custom-select:invalid~.invalid-feedback,
		.was-validated .custom-select:invalid~.invalid-tooltip,
		.custom-select.is-invalid~.invalid-feedback,
		.custom-select.is-invalid~.invalid-tooltip {
		    display: block;
		}
		
		.was-validated .form-check-input:invalid~.form-check-label,
		.form-check-input.is-invalid~.form-check-label {
		    color: #f62d51;
		}
		
		.was-validated .form-check-input:invalid~.invalid-feedback,
		.was-validated .form-check-input:invalid~.invalid-tooltip,
		.form-check-input.is-invalid~.invalid-feedback,
		.form-check-input.is-invalid~.invalid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-control-input:invalid~.custom-control-label,
		.custom-control-input.is-invalid~.custom-control-label {
		    color: #f62d51;
		}
		
		.was-validated .custom-control-input:invalid~.custom-control-label::before,
		.custom-control-input.is-invalid~.custom-control-label::before {
		    background-color: #fba7b6;
		}
		
		.was-validated .custom-control-input:invalid~.invalid-feedback,
		.was-validated .custom-control-input:invalid~.invalid-tooltip,
		.custom-control-input.is-invalid~.invalid-feedback,
		.custom-control-input.is-invalid~.invalid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-control-input:invalid:checked~.custom-control-label::before,
		.custom-control-input.is-invalid:checked~.custom-control-label::before {
		    background-color: #f85e7a;
		}
		
		.was-validated .custom-control-input:invalid:focus~.custom-control-label::before,
		.custom-control-input.is-invalid:focus~.custom-control-label::before {
		    -webkit-box-shadow: 0 0 0 1px #eef5f9, 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		    box-shadow: 0 0 0 1px #eef5f9, 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		}
		
		.was-validated .custom-file-input:invalid~.custom-file-label,
		.custom-file-input.is-invalid~.custom-file-label {
		    border-color: #f62d51;
		}
		
		.was-validated .custom-file-input:invalid~.custom-file-label::before,
		.custom-file-input.is-invalid~.custom-file-label::before {
		    border-color: inherit;
		}
		
		.was-validated .custom-file-input:invalid~.invalid-feedback,
		.was-validated .custom-file-input:invalid~.invalid-tooltip,
		.custom-file-input.is-invalid~.invalid-feedback,
		.custom-file-input.is-invalid~.invalid-tooltip {
		    display: block;
		}
		
		.was-validated .custom-file-input:invalid:focus~.custom-file-label,
		.custom-file-input.is-invalid:focus~.custom-file-label {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		    box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.25);
		}
		
		.form-inline {
		    display: -webkit-box;
		    display: -ms-flexbox;
		    display: flex;
		    -webkit-box-orient: horizontal;
		    -webkit-box-direction: normal;
		    -ms-flex-flow: row wrap;
		    flex-flow: row wrap;
		    -webkit-box-align: center;
		    -ms-flex-align: center;
		    align-items: center;
		}
		
		.form-inline .form-check {
		    width: 100%;
		}
		
		@media (min-width: 576px) {
		    .form-inline label {
		        display: -webkit-box;
		        display: -ms-flexbox;
		        display: flex;
		        -webkit-box-align: center;
		        -ms-flex-align: center;
		        align-items: center;
		        -webkit-box-pack: center;
		        -ms-flex-pack: center;
		        justify-content: center;
		        margin-bottom: 0;
		    }
		
		    .form-inline .form-group {
		        display: -webkit-box;
		        display: -ms-flexbox;
		        display: flex;
		        -webkit-box-flex: 0;
		        -ms-flex: 0 0 auto;
		        flex: 0 0 auto;
		        -webkit-box-orient: horizontal;
		        -webkit-box-direction: normal;
		        -ms-flex-flow: row wrap;
		        flex-flow: row wrap;
		        -webkit-box-align: center;
		        -ms-flex-align: center;
		        align-items: center;
		        margin-bottom: 0;
		    }
		
		    .form-inline .form-control {
		        display: inline-block;
		        width: auto;
		        vertical-align: middle;
		    }
		
		    .form-inline .form-control-plaintext {
		        display: inline-block;
		    }
		
		    .form-inline .input-group,
		    .form-inline .custom-select {
		        width: auto;
		    }
		
		    .form-inline .form-check {
		        display: -webkit-box;
		        display: -ms-flexbox;
		        display: flex;
		        -webkit-box-align: center;
		        -ms-flex-align: center;
		        align-items: center;
		        -webkit-box-pack: center;
		        -ms-flex-pack: center;
		        justify-content: center;
		        width: auto;
		        padding-left: 0;
		    }
		
		    .form-inline .form-check-input {
		        position: relative;
		        margin-top: 0;
		        margin-right: 0.25rem;
		        margin-left: 0;
		    }
		
		    .form-inline .custom-control {
		        -webkit-box-align: center;
		        -ms-flex-align: center;
		        align-items: center;
		        -webkit-box-pack: center;
		        -ms-flex-pack: center;
		        justify-content: center;
		    }
		
		    .form-inline .custom-control-label {
		        margin-bottom: 0;
		    }
		}
		
		.btn {
		    display: inline-block;
		    font-weight: 400;
		    text-align: center;
		    white-space: nowrap;
		    vertical-align: middle;
		    -webkit-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    user-select: none;
		    border: 1px solid transparent;
		    padding: 0.375rem 0.75rem;
		    font-size: 0.875rem;
		    line-height: 1.5;
		    border-radius: 2px;
		    -webkit-transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		    -o-transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
		    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
		    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out, -webkit-box-shadow 0.15s ease-in-out;
		}
		
		@media screen and (prefers-reduced-motion: reduce) {
		    .btn {
		        -webkit-transition: none;
		        -o-transition: none;
		        transition: none;
		    }
		}
		
		.btn:hover,
		.btn:focus {
		    text-decoration: none;
		}
		
		.btn:focus,
		.btn.focus {
		    outline: 0;
		    -webkit-box-shadow: transparent;
		    box-shadow: transparent;
		}
		
		.btn.disabled,
		.btn:disabled {
		    opacity: 0.65;
		}
		
		.btn:not(:disabled):not(.disabled) {
		    cursor: pointer;
		}
		
		.btn:not(:disabled):not(.disabled):active,
		.btn:not(:disabled):not(.disabled).active {
		    background-image: none;
		}
		
		a.btn.disabled,
		fieldset:disabled a.btn {
		    pointer-events: none;
		}
		
		.btn-primary {
		    color: #fff;
		    background-color: #7460ee;
		    border-color: #7460ee;
		}
		
		.btn-primary:hover {
		    color: #fff;
		    background-color: #563dea;
		    border-color: #4c32e9;
		}
		
		.btn-primary:focus,
		.btn-primary.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		}
		
		.btn-primary.disabled,
		.btn-primary:disabled {
		    color: #fff;
		    background-color: #7460ee;
		    border-color: #7460ee;
		}
		
		.btn-primary:not(:disabled):not(.disabled):active,
		.btn-primary:not(:disabled):not(.disabled).active,
		.show>.btn-primary.dropdown-toggle {
		    color: #fff;
		    background-color: #4c32e9;
		    border-color: #4226e8;
		}
		
		.btn-primary:not(:disabled):not(.disabled):active:focus,
		.btn-primary:not(:disabled):not(.disabled).active:focus,
		.show>.btn-primary.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		}
		
		.btn-secondary {
		    color: #fff;
		    background-color: #6c757d;
		    border-color: #6c757d;
		}
		
		.btn-secondary:hover {
		    color: #fff;
		    background-color: #5a6268;
		    border-color: #545b62;
		}
		
		.btn-secondary:focus,
		.btn-secondary.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(108, 117, 125, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(108, 117, 125, 0.5);
		}
		
		.btn-secondary.disabled,
		.btn-secondary:disabled {
		    color: #fff;
		    background-color: #6c757d;
		    border-color: #6c757d;
		}
		
		.btn-secondary:not(:disabled):not(.disabled):active,
		.btn-secondary:not(:disabled):not(.disabled).active,
		.show>.btn-secondary.dropdown-toggle {
		    color: #fff;
		    background-color: #545b62;
		    border-color: #4e555b;
		}
		
		.btn-secondary:not(:disabled):not(.disabled):active:focus,
		.btn-secondary:not(:disabled):not(.disabled).active:focus,
		.show>.btn-secondary.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(108, 117, 125, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(108, 117, 125, 0.5);
		}
		
		.btn-success {
		    color: #fff;
		    background-color: #36bea6;
		    border-color: #36bea6;
		}
		
		.btn-success:hover {
		    color: #fff;
		    background-color: #2ea08c;
		    border-color: #2b9683;
		}
		
		.btn-success:focus,
		.btn-success.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.5);
		}
		
		.btn-success.disabled,
		.btn-success:disabled {
		    color: #fff;
		    background-color: #36bea6;
		    border-color: #36bea6;
		}
		
		.btn-success:not(:disabled):not(.disabled):active,
		.btn-success:not(:disabled):not(.disabled).active,
		.show>.btn-success.dropdown-toggle {
		    color: #fff;
		    background-color: #2b9683;
		    border-color: #288c7b;
		}
		
		.btn-success:not(:disabled):not(.disabled):active:focus,
		.btn-success:not(:disabled):not(.disabled).active:focus,
		.show>.btn-success.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(54, 190, 166, 0.5);
		}
		
		.btn-info {
		    color: #fff;
		    background-color: #2962FF;
		    border-color: #2962FF;
		}
		
		.btn-info:hover {
		    color: #fff;
		    background-color: #0346ff;
		    border-color: #0041f5;
		}
		
		.btn-info:focus,
		.btn-info.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(41, 98, 255, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(41, 98, 255, 0.5);
		}
		
		.btn-info.disabled,
		.btn-info:disabled {
		    color: #fff;
		    background-color: #2962FF;
		    border-color: #2962FF;
		}
		
		.btn-info:not(:disabled):not(.disabled):active,
		.btn-info:not(:disabled):not(.disabled).active,
		.show>.btn-info.dropdown-toggle {
		    color: #fff;
		    background-color: #0041f5;
		    border-color: #003ee8;
		}
		
		.btn-info:not(:disabled):not(.disabled):active:focus,
		.btn-info:not(:disabled):not(.disabled).active:focus,
		.show>.btn-info.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(41, 98, 255, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(41, 98, 255, 0.5);
		}
		
		.btn-warning {
		    color: #212529;
		    background-color: #ffbc34;
		    border-color: #ffbc34;
		}
		
		.btn-warning:hover {
		    color: #212529;
		    background-color: #ffaf0e;
		    border-color: #ffab01;
		}
		
		.btn-warning:focus,
		.btn-warning.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(255, 188, 52, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(255, 188, 52, 0.5);
		}
		
		.btn-warning.disabled,
		.btn-warning:disabled {
		    color: #212529;
		    background-color: #ffbc34;
		    border-color: #ffbc34;
		}
		
		.btn-warning:not(:disabled):not(.disabled):active,
		.btn-warning:not(:disabled):not(.disabled).active,
		.show>.btn-warning.dropdown-toggle {
		    color: #212529;
		    background-color: #ffab01;
		    border-color: #f3a300;
		}
		
		.btn-warning:not(:disabled):not(.disabled):active:focus,
		.btn-warning:not(:disabled):not(.disabled).active:focus,
		.show>.btn-warning.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(255, 188, 52, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(255, 188, 52, 0.5);
		}
		
		.btn-danger {
		    color: #fff;
		    background-color: #f62d51;
		    border-color: #f62d51;
		}
		
		.btn-danger:hover {
		    color: #fff;
		    background-color: #f20a34;
		    border-color: #e60a31;
		}
		
		.btn-danger:focus,
		.btn-danger.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.5);
		}
		
		.btn-danger.disabled,
		.btn-danger:disabled {
		    color: #fff;
		    background-color: #f62d51;
		    border-color: #f62d51;
		}
		
		.btn-danger:not(:disabled):not(.disabled):active,
		.btn-danger:not(:disabled):not(.disabled).active,
		.show>.btn-danger.dropdown-toggle {
		    color: #fff;
		    background-color: #e60a31;
		    border-color: #da092f;
		}
		
		.btn-danger:not(:disabled):not(.disabled):active:focus,
		.btn-danger:not(:disabled):not(.disabled).active:focus,
		.show>.btn-danger.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(246, 45, 81, 0.5);
		}
		
		.btn-light {
		    color: #212529;
		    background-color: #f8f9fa;
		    border-color: #f8f9fa;
		}
		
		.btn-light:hover {
		    color: #212529;
		    background-color: #e2e6ea;
		    border-color: #dae0e5;
		}
		
		.btn-light:focus,
		.btn-light.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(248, 249, 250, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(248, 249, 250, 0.5);
		}
		
		.btn-light.disabled,
		.btn-light:disabled {
		    color: #212529;
		    background-color: #f8f9fa;
		    border-color: #f8f9fa;
		}
		
		.btn-light:not(:disabled):not(.disabled):active,
		.btn-light:not(:disabled):not(.disabled).active,
		.show>.btn-light.dropdown-toggle {
		    color: #212529;
		    background-color: #dae0e5;
		    border-color: #d3d9df;
		}
		
		.btn-light:not(:disabled):not(.disabled):active:focus,
		.btn-light:not(:disabled):not(.disabled).active:focus,
		.show>.btn-light.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(248, 249, 250, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(248, 249, 250, 0.5);
		}
		
		.btn-dark {
		    color: #fff;
		    background-color: #343a40;
		    border-color: #343a40;
		}
		
		.btn-dark:hover {
		    color: #fff;
		    background-color: #23272b;
		    border-color: #1d2124;
		}
		
		.btn-dark:focus,
		.btn-dark.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
		}
		
		.btn-dark.disabled,
		.btn-dark:disabled {
		    color: #fff;
		    background-color: #343a40;
		    border-color: #343a40;
		}
		
		.btn-dark:not(:disabled):not(.disabled):active,
		.btn-dark:not(:disabled):not(.disabled).active,
		.show>.btn-dark.dropdown-toggle {
		    color: #fff;
		    background-color: #1d2124;
		    border-color: #171a1d;
		}
		
		.btn-dark:not(:disabled):not(.disabled):active:focus,
		.btn-dark:not(:disabled):not(.disabled).active:focus,
		.show>.btn-dark.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.5);
		}
		
		.btn-cyan {
		    color: #212529;
		    background-color: #4fc3f7;
		    border-color: #4fc3f7;
		}
		
		.btn-cyan:hover {
		    color: #fff;
		    background-color: #2ab7f5;
		    border-color: #1eb2f5;
		}
		
		.btn-cyan:focus,
		.btn-cyan.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(79, 195, 247, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(79, 195, 247, 0.5);
		}
		
		.btn-cyan.disabled,
		.btn-cyan:disabled {
		    color: #212529;
		    background-color: #4fc3f7;
		    border-color: #4fc3f7;
		}
		
		.btn-cyan:not(:disabled):not(.disabled):active,
		.btn-cyan:not(:disabled):not(.disabled).active,
		.show>.btn-cyan.dropdown-toggle {
		    color: #fff;
		    background-color: #1eb2f5;
		    border-color: #12aef4;
		}
		
		.btn-cyan:not(:disabled):not(.disabled):active:focus,
		.btn-cyan:not(:disabled):not(.disabled).active:focus,
		.show>.btn-cyan.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(79, 195, 247, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(79, 195, 247, 0.5);
		}
		
		.btn-orange {
		    color: #212529;
		    background-color: #fb8c00;
		    border-color: #fb8c00;
		}
		
		.btn-orange:hover {
		    color: #fff;
		    background-color: #d57700;
		    border-color: #c87000;
		}
		
		.btn-orange:focus,
		.btn-orange.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(251, 140, 0, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(251, 140, 0, 0.5);
		}
		
		.btn-orange.disabled,
		.btn-orange:disabled {
		    color: #212529;
		    background-color: #fb8c00;
		    border-color: #fb8c00;
		}
		
		.btn-orange:not(:disabled):not(.disabled):active,
		.btn-orange:not(:disabled):not(.disabled).active,
		.show>.btn-orange.dropdown-toggle {
		    color: #fff;
		    background-color: #c87000;
		    border-color: #bb6800;
		}
		
		.btn-orange:not(:disabled):not(.disabled):active:focus,
		.btn-orange:not(:disabled):not(.disabled).active:focus,
		.show>.btn-orange.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(251, 140, 0, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(251, 140, 0, 0.5);
		}
		
		.btn-purple {
		    color: #fff;
		    background-color: #7460ee;
		    border-color: #7460ee;
		}
		
		.btn-purple:hover {
		    color: #fff;
		    background-color: #563dea;
		    border-color: #4c32e9;
		}
		
		.btn-purple:focus,
		.btn-purple.focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		}
		
		.btn-purple.disabled,
		.btn-purple:disabled {
		    color: #fff;
		    background-color: #7460ee;
		    border-color: #7460ee;
		}
		
		.btn-purple:not(:disabled):not(.disabled):active,
		.btn-purple:not(:disabled):not(.disabled).active,
		.show>.btn-purple.dropdown-toggle {
		    color: #fff;
		    background-color: #4c32e9;
		    border-color: #4226e8;
		}
		
		.btn-purple:not(:disabled):not(.disabled):active:focus,
		.btn-purple:not(:disabled):not(.disabled).active:focus,
		.show>.btn-purple.dropdown-toggle:focus {
		    -webkit-box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		    box-shadow: 0 0 0 0.2rem rgba(116, 96, 238, 0.5);
		}
		
		.custom-control {
		    position: relative;
		    display: block;
		    min-height: 1.5rem;
		    padding-left: 1.5rem;
		}
		
		.custom-control-inline {
		    display: -webkit-inline-box;
		    display: -ms-inline-flexbox;
		    display: inline-flex;
		    margin-right: 1rem;
		}
		
		.custom-control-input {
		    position: absolute;
		    z-index: -1;
		    opacity: 0;
		}
		
		.custom-control-input:checked~.custom-control-label::before {
		    color: #fff;
		    background-color: #2962FF;
		}
		
		.custom-control-input:focus~.custom-control-label::before {
		    -webkit-box-shadow: 0 0 0 1px #eef5f9, transparent;
		    box-shadow: 0 0 0 1px #eef5f9, transparent;
		}
		
		.custom-control-input:active~.custom-control-label::before {
		    color: #fff;
		    background-color: black;
		}
		
		.custom-control-input:disabled~.custom-control-label {
		    color: #6c757d;
		}
		
		.custom-control-input:disabled~.custom-control-label::before {
		    background-color: #e9ecef;
		}
		
		.custom-control-label {
		    margin-bottom: 0;
		}
		
		.custom-control-label::before {
		    position: absolute;
		    top: 0.25rem;
		    left: 0;
		    display: block;
		    width: 1rem;
		    height: 1rem;
		    pointer-events: none;
		    content: "";
		    -webkit-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    user-select: none;
		    background-color: #dee2e6;
		}
		
		.custom-control-label::after {
		    position: absolute;
		    top: 0.25rem;
		    left: 0;
		    display: block;
		    width: 1rem;
		    height: 1rem;
		    content: "";
		    background-repeat: no-repeat;
		    background-position: center center;
		    background-size: 50% 50%;
		}
		
		.custom-checkbox .custom-control-label::before {
		    border-radius: 2px;
		}
		
		.custom-checkbox .custom-control-input:checked~.custom-control-label::before {
		    background-color: #2962FF;
		}
		
		.custom-checkbox .custom-control-input:checked~.custom-control-label::after {
		    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath fill='%23fff' d='M6.564.75l-3.59 3.612-1.538-1.55L0 4.26 2.974 7.25 8 2.193z'/%3E%3C/svg%3E");
		}
		
		.custom-checkbox .custom-control-input:indeterminate~.custom-control-label::before {
		    background-color: #2962FF;
		}
		
		.custom-checkbox .custom-control-input:indeterminate~.custom-control-label::after {
		    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 4'%3E%3Cpath stroke='%23fff' d='M0 2h4'/%3E%3C/svg%3E");
		}
		
		.custom-checkbox .custom-control-input:disabled:checked~.custom-control-label::before {
		    background-color: rgba(116, 96, 238, 0.5);
		}
		
		.custom-checkbox .custom-control-input:disabled:indeterminate~.custom-control-label::before {
		    background-color: rgba(116, 96, 238, 0.5);
		}
		
		.custom-radio .custom-control-label::before {
		    border-radius: 50%;
		}
		
		.custom-radio .custom-control-input:checked~.custom-control-label::before {
		    background-color: #2962FF;
		}
		
		.custom-radio .custom-control-input:checked~.custom-control-label::after {
		    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3E%3Ccircle r='3' fill='%23fff'/%3E%3C/svg%3E");
		}
		
		.custom-radio .custom-control-input:disabled:checked~.custom-control-label::before {
		    background-color: rgba(116, 96, 238, 0.5);
		}
		
		.custom-select {
		    display: inline-block;
		    width: 100%;
		    height: calc(2.0625rem + 2px);
		    padding: 0.375rem 1.75rem 0.375rem 0.75rem;
		    line-height: 1.5;
		    color: #4F5467;
		    vertical-align: middle;
		    background: #fff url(../../assets/images/custom-select.png) no-repeat right 0.75rem center;
		    background-size: 8px 10px;
		    border: 1px solid #e9ecef;
		    border-radius: 2px;
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    appearance: none;
		}
		
		.custom-select:focus {
		    border-color: rgba(0, 0, 0, 0.25);
		    outline: 0;
		    -webkit-box-shadow: transparent;
		    box-shadow: transparent;
		}
		
		.custom-select:focus::-ms-value {
		    color: #4F5467;
		    background-color: #fff;
		}
		
		.custom-select[multiple],
		.custom-select[size]:not([size="1"]) {
		    height: auto;
		    padding-right: 0.75rem;
		    background-image: none;
		}
		
		.custom-select:disabled {
		    color: #6c757d;
		    background-color: #e9ecef;
		}
		
		.custom-select::-ms-expand {
		    opacity: 0;
		}
		
		.custom-select-sm {
		    height: calc(1.64844rem + 2px);
		    padding-top: 0.375rem;
		    padding-bottom: 0.375rem;
		    font-size: 75%;
		}
		
		.custom-select-lg {
		    height: calc(2.64063rem + 2px);
		    padding-top: 0.375rem;
		    padding-bottom: 0.375rem;
		    font-size: 125%;
		}
		
		.custom-file {
		    position: relative;
		    display: inline-block;
		    width: 100%;
		    height: calc(2.0625rem + 2px);
		    margin-bottom: 0;
		}
		
		.custom-file-input {
		    position: relative;
		    z-index: 2;
		    width: 100%;
		    height: calc(2.0625rem + 2px);
		    margin: 0;
		    opacity: 0;
		}
		
		.custom-file-input:focus~.custom-file-label {
		    border-color: rgba(0, 0, 0, 0.25);
		    -webkit-box-shadow: transparent;
		    box-shadow: transparent;
		}
		
		.custom-file-input:focus~.custom-file-label::after {
		    border-color: rgba(0, 0, 0, 0.25);
		}
		
		.custom-file-input:lang(en)~.custom-file-label::after {
		    content: "Browse";
		}
		
		.custom-file-label {
		    position: absolute;
		    top: 0;
		    right: 0;
		    left: 0;
		    z-index: 1;
		    height: calc(2.0625rem + 2px);
		    padding: 0.375rem 0.75rem;
		    line-height: 1.5;
		    color: #4F5467;
		    background-color: #fff;
		    border: 1px solid #e9ecef;
		    border-radius: 2px;
		}
		
		.custom-file-label::after {
		    position: absolute;
		    top: 0;
		    right: 0;
		    bottom: 0;
		    z-index: 3;
		    display: block;
		    height: calc(calc(2.0625rem + 2px) - 1px * 2);
		    padding: 0.375rem 0.75rem;
		    line-height: 1.5;
		    color: #4F5467;
		    content: "Browse";
		    background-color: #f8f9fa;
		    border-left: 1px solid #e9ecef;
		    border-radius: 0 2px 2px 0;
		}
		
		.select2-container--classic .select2-selection--single,
		.select2-container--default .select2-selection--single,
		.select2-container--default .select2-selection--single .select2-selection__rendered,
		.select2-container--default .select2-selection--single .select2-selection__arrow,
		.select2-container--default .select2-selection--multiple {
		    border-color: #e9ecef;
		    height: 40px;
		    color: #3e5569;
		    line-height: 40px;
		}
		
		.select2-container--default .select2-selection--multiple {
		    line-height: 27px;
		}
		
		.select2-container--classic .select2-selection--multiple .select2-selection__choice,
		.select2-container--default .select2-selection--multiple .select2-selection__choice,
		.select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
		    background-color: #2962FF;
		    border-color: #2962FF;
		    color: #fff;
		}
		
		.select2-container {
    box-sizing: border-box;
    display: inline-block;
    margin: 0;
    position: relative;
    vertical-align: middle
}

.select2-container .select2-selection--single {
    box-sizing: border-box;
    cursor: pointer;
    display: block;
    height: 28px;
    user-select: none;
    -webkit-user-select: none
}

.select2-container .select2-selection--single .select2-selection__rendered {
    display: block;
    padding-left: 8px;
    padding-right: 20px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap
}

.select2-container .select2-selection--single .select2-selection__clear {
    position: relative
}

.select2-container[dir="rtl"] .select2-selection--single .select2-selection__rendered {
    padding-right: 8px;
    padding-left: 20px
}

.select2-container .select2-selection--multiple {
    box-sizing: border-box;
    cursor: pointer;
    display: block;
    min-height: 32px;
    user-select: none;
    -webkit-user-select: none
}

.select2-container .select2-selection--multiple .select2-selection__rendered {
    display: inline-block;
    overflow: hidden;
    padding-left: 8px;
    text-overflow: ellipsis;
    white-space: nowrap
}

.select2-container .select2-search--inline {
    float: left
}

.select2-container .select2-search--inline .select2-search__field {
    box-sizing: border-box;
    border: none;
    font-size: 100%;
    margin-top: 5px;
    padding: 0
}

.select2-container .select2-search--inline .select2-search__field::-webkit-search-cancel-button {
    -webkit-appearance: none
}

.select2-dropdown {
    background-color: white;
    border: 1px solid #aaa;
    border-radius: 4px;
    box-sizing: border-box;
    display: block;
    position: absolute;
    left: -100000px;
    width: 100%;
    z-index: 1051
}

.select2-results {
    display: block
}

.select2-results__options {
    list-style: none;
    margin: 0;
    padding: 0
}

.select2-results__option {
    padding: 6px;
    user-select: none;
    -webkit-user-select: none
}

.select2-results__option[aria-selected] {
    cursor: pointer
}

.select2-container--open .select2-dropdown {
    left: 0
}

.select2-container--open .select2-dropdown--above {
    border-bottom: none;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0
}

.select2-container--open .select2-dropdown--below {
    border-top: none;
    border-top-left-radius: 0;
    border-top-right-radius: 0
}

.select2-search--dropdown {
    display: block;
    padding: 4px
}

.select2-search--dropdown .select2-search__field {
    padding: 4px;
    width: 100%;
    box-sizing: border-box
}

.select2-search--dropdown .select2-search__field::-webkit-search-cancel-button {
    -webkit-appearance: none
}

.select2-search--dropdown.select2-search--hide {
    display: none
}

.select2-close-mask {
    border: 0;
    margin: 0;
    padding: 0;
    display: block;
    position: fixed;
    left: 0;
    top: 0;
    min-height: 100%;
    min-width: 100%;
    height: auto;
    width: auto;
    opacity: 0;
    z-index: 99;
    background-color: #fff;
    filter: alpha(opacity=0)
}

.select2-hidden-accessible {
    border: 0 !important;
    clip: rect(0 0 0 0) !important;
    -webkit-clip-path: inset(50%) !important;
    clip-path: inset(50%) !important;
    height: 1px !important;
    overflow: hidden !important;
    padding: 0 !important;
    position: absolute !important;
    width: 1px !important;
    white-space: nowrap !important
}

.select2-container--default .select2-selection--single {
    background-color: #fff;
    border: 1px solid #aaa;
    border-radius: 4px
}

.select2-container--default .select2-selection--single .select2-selection__rendered {
    color: #444;
    line-height: 28px
}

.select2-container--default .select2-selection--single .select2-selection__clear {
    cursor: pointer;
    float: right;
    font-weight: bold
}

.select2-container--default .select2-selection--single .select2-selection__placeholder {
    color: #999
}

.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 26px;
    position: absolute;
    top: 1px;
    right: 1px;
    width: 20px
}

.select2-container--default .select2-selection--single .select2-selection__arrow b {
    border-color: #888 transparent transparent transparent;
    border-style: solid;
    border-width: 5px 4px 0 4px;
    height: 0;
    left: 50%;
    margin-left: -4px;
    margin-top: -2px;
    position: absolute;
    top: 50%;
    width: 0
}

.select2-container--default[dir="rtl"] .select2-selection--single .select2-selection__clear {
    float: left
}

.select2-container--default[dir="rtl"] .select2-selection--single .select2-selection__arrow {
    left: 1px;
    right: auto
}

.select2-container--default.select2-container--disabled .select2-selection--single {
    background-color: #eee;
    cursor: default
}

.select2-container--default.select2-container--disabled .select2-selection--single .select2-selection__clear {
    display: none
}

.select2-container--default.select2-container--open .select2-selection--single .select2-selection__arrow b {
    border-color: transparent transparent #888 transparent;
    border-width: 0 4px 5px 4px
}

.select2-container--default .select2-selection--multiple {
    background-color: white;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: text
}

.select2-container--default .select2-selection--multiple .select2-selection__rendered {
    box-sizing: border-box;
    list-style: none;
    margin: 0;
    padding: 0 5px;
    width: 100%
}

.select2-container--default .select2-selection--multiple .select2-selection__rendered li {
    list-style: none
}

.select2-container--default .select2-selection--multiple .select2-selection__placeholder {
    color: #999;
    margin-top: 5px;
    float: left
}

.select2-container--default .select2-selection--multiple .select2-selection__clear {
    cursor: pointer;
    float: right;
    font-weight: bold;
    margin-top: 5px;
    margin-right: 10px
}

.select2-container--default .select2-selection--multiple .select2-selection__choice {
    background-color: #e4e4e4;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: default;
    float: left;
    margin-right: 5px;
    margin-top: 5px;
    padding: 0 5px
}

.select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
    color: #999;
    cursor: pointer;
    display: inline-block;
    font-weight: bold;
    margin-right: 2px
}

.select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {
    color: #333
}

.select2-container--default[dir="rtl"] .select2-selection--multiple .select2-selection__choice,
.select2-container--default[dir="rtl"] .select2-selection--multiple .select2-selection__placeholder,
.select2-container--default[dir="rtl"] .select2-selection--multiple .select2-search--inline {
    float: right
}

.select2-container--default[dir="rtl"] .select2-selection--multiple .select2-selection__choice {
    margin-left: 5px;
    margin-right: auto
}

.select2-container--default[dir="rtl"] .select2-selection--multiple .select2-selection__choice__remove {
    margin-left: 2px;
    margin-right: auto
}

.select2-container--default.select2-container--focus .select2-selection--multiple {
    border: solid black 1px;
    outline: 0
}

.select2-container--default.select2-container--disabled .select2-selection--multiple {
    background-color: #eee;
    cursor: default
}

.select2-container--default.select2-container--disabled .select2-selection__choice__remove {
    display: none
}

.select2-container--default.select2-container--open.select2-container--above .select2-selection--single,
.select2-container--default.select2-container--open.select2-container--above .select2-selection--multiple {
    border-top-left-radius: 0;
    border-top-right-radius: 0
}

.select2-container--default.select2-container--open.select2-container--below .select2-selection--single,
.select2-container--default.select2-container--open.select2-container--below .select2-selection--multiple {
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0
}

.select2-container--default .select2-search--dropdown .select2-search__field {
    border: 1px solid #aaa
}

.select2-container--default .select2-search--inline .select2-search__field {
    background: transparent;
    border: none;
    outline: 0;
    box-shadow: none;
    -webkit-appearance: textfield
}

.select2-container--default .select2-results>.select2-results__options {
    max-height: 200px;
    overflow-y: auto
}

.select2-container--default .select2-results__option[role=group] {
    padding: 0
}

.select2-container--default .select2-results__option[aria-disabled=true] {
    color: #999
}

.select2-container--default .select2-results__option[aria-selected=true] {
    background-color: #ddd
}

.select2-container--default .select2-results__option .select2-results__option {
    padding-left: 1em
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__group {
    padding-left: 0
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__option {
    margin-left: -1em;
    padding-left: 2em
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__option .select2-results__option {
    margin-left: -2em;
    padding-left: 3em
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option {
    margin-left: -3em;
    padding-left: 4em
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option {
    margin-left: -4em;
    padding-left: 5em
}

.select2-container--default .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option .select2-results__option {
    margin-left: -5em;
    padding-left: 6em
}

.select2-container--default .select2-results__option--highlighted[aria-selected] {
    background-color: #5897fb;
    color: white
}

.select2-container--default .select2-results__group {
    cursor: default;
    display: block;
    padding: 6px
}

.select2-container--classic .select2-selection--single {
    background-color: #f7f7f7;
    border: 1px solid #aaa;
    border-radius: 4px;
    outline: 0;
    background-image: -webkit-linear-gradient(top, #fff 50%, #eee 100%);
    background-image: -o-linear-gradient(top, #fff 50%, #eee 100%);
    background-image: linear-gradient(to bottom, #fff 50%, #eee 100%);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFFFFFFF', endColorstr='#FFEEEEEE', GradientType=0)
}

.select2-container--classic .select2-selection--single:focus {
    border: 1px solid #5897fb
}

.select2-container--classic .select2-selection--single .select2-selection__rendered {
    color: #444;
    line-height: 28px
}

.select2-container--classic .select2-selection--single .select2-selection__clear {
    cursor: pointer;
    float: right;
    font-weight: bold;
    margin-right: 10px
}

.select2-container--classic .select2-selection--single .select2-selection__placeholder {
    color: #999
}

.select2-container--classic .select2-selection--single .select2-selection__arrow {
    background-color: #ddd;
    border: none;
    border-left: 1px solid #aaa;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
    height: 26px;
    position: absolute;
    top: 1px;
    right: 1px;
    width: 20px;
    background-image: -webkit-linear-gradient(top, #eee 50%, #ccc 100%);
    background-image: -o-linear-gradient(top, #eee 50%, #ccc 100%);
    background-image: linear-gradient(to bottom, #eee 50%, #ccc 100%);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFEEEEEE', endColorstr='#FFCCCCCC', GradientType=0)
}

.select2-container--classic .select2-selection--single .select2-selection__arrow b {
    border-color: #888 transparent transparent transparent;
    border-style: solid;
    border-width: 5px 4px 0 4px;
    height: 0;
    left: 50%;
    margin-left: -4px;
    margin-top: -2px;
    position: absolute;
    top: 50%;
    width: 0
}

.select2-container--classic[dir="rtl"] .select2-selection--single .select2-selection__clear {
    float: left
}

.select2-container--classic[dir="rtl"] .select2-selection--single .select2-selection__arrow {
    border: none;
    border-right: 1px solid #aaa;
    border-radius: 0;
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
    left: 1px;
    right: auto
}

.select2-container--classic.select2-container--open .select2-selection--single {
    border: 1px solid #5897fb
}

.select2-container--classic.select2-container--open .select2-selection--single .select2-selection__arrow {
    background: transparent;
    border: none
}

.select2-container--classic.select2-container--open .select2-selection--single .select2-selection__arrow b {
    border-color: transparent transparent #888 transparent;
    border-width: 0 4px 5px 4px
}

.select2-container--classic.select2-container--open.select2-container--above .select2-selection--single {
    border-top: none;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    background-image: -webkit-linear-gradient(top, #fff 0%, #eee 50%);
    background-image: -o-linear-gradient(top, #fff 0%, #eee 50%);
    background-image: linear-gradient(to bottom, #fff 0%, #eee 50%);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFFFFFFF', endColorstr='#FFEEEEEE', GradientType=0)
}

.select2-container--classic.select2-container--open.select2-container--below .select2-selection--single {
    border-bottom: none;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    background-image: -webkit-linear-gradient(top, #eee 50%, #fff 100%);
    background-image: -o-linear-gradient(top, #eee 50%, #fff 100%);
    background-image: linear-gradient(to bottom, #eee 50%, #fff 100%);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFEEEEEE', endColorstr='#FFFFFFFF', GradientType=0)
}

.select2-container--classic .select2-selection--multiple {
    background-color: white;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: text;
    outline: 0
}

.select2-container--classic .select2-selection--multiple:focus {
    border: 1px solid #5897fb
}

.select2-container--classic .select2-selection--multiple .select2-selection__rendered {
    list-style: none;
    margin: 0;
    padding: 0 5px
}

.select2-container--classic .select2-selection--multiple .select2-selection__clear {
    display: none
}

.select2-container--classic .select2-selection--multiple .select2-selection__choice {
    background-color: #e4e4e4;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: default;
    float: left;
    margin-right: 5px;
    margin-top: 5px;
    padding: 0 5px
}

.select2-container--classic .select2-selection--multiple .select2-selection__choice__remove {
    color: #888;
    cursor: pointer;
    display: inline-block;
    font-weight: bold;
    margin-right: 2px
}

.select2-container--classic .select2-selection--multiple .select2-selection__choice__remove:hover {
    color: #555
}

.select2-container--classic[dir="rtl"] .select2-selection--multiple .select2-selection__choice {
    float: right;
    margin-left: 5px;
    margin-right: auto
}

.select2-container--classic[dir="rtl"] .select2-selection--multiple .select2-selection__choice__remove {
    margin-left: 2px;
    margin-right: auto
}

.select2-container--classic.select2-container--open .select2-selection--multiple {
    border: 1px solid #5897fb
}

.select2-container--classic.select2-container--open.select2-container--above .select2-selection--multiple {
    border-top: none;
    border-top-left-radius: 0;
    border-top-right-radius: 0
}

.select2-container--classic.select2-container--open.select2-container--below .select2-selection--multiple {
    border-bottom: none;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0
}

.select2-container--classic .select2-search--dropdown .select2-search__field {
    border: 1px solid #aaa;
    outline: 0
}

.select2-container--classic .select2-search--inline .select2-search__field {
    outline: 0;
    box-shadow: none
}

.select2-container--classic .select2-dropdown {
    background-color: #fff;
    border: 1px solid transparent
}

.select2-container--classic .select2-dropdown--above {
    border-bottom: none
}

.select2-container--classic .select2-dropdown--below {
    border-top: none
}

.select2-container--classic .select2-results>.select2-results__options {
    max-height: 200px;
    overflow-y: auto
}

.select2-container--classic .select2-results__option[role=group] {
    padding: 0
}

.select2-container--classic .select2-results__option[aria-disabled=true] {
    color: grey
}

.select2-container--classic .select2-results__option--highlighted[aria-selected] {
    background-color: #3875d7;
    color: #fff
}

.select2-container--classic .select2-results__group {
    cursor: default;
    display: block;
    padding: 6px
}

.select2-container--classic.select2-container--open .select2-dropdown {
    border-color: #5897fb
}
    </style>
    
</head>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
			<div class="card">
                <div class="card-body">
                    <h5 class="card-title">Form Elements</h5>
                    <div class="form-group row">
                        <label class="col-md-3 m-t-15">Single Select</label>
                        <div class="col-md-9">
                            <select class="select2 form-control custom-select" style="width: 100%; height:36px;">
                                <option>Select</option>
                                <optgroup label="Alaskan/Hawaiian Time Zone">
                                    <option value="AK">Alaska</option>
                                    <option value="HI">Hawaii</option>
                                </optgroup>
                                <optgroup label="Pacific Time Zone">
                                    <option value="CA">California</option>
                                    <option value="NV">Nevada</option>
                                    <option value="OR">Oregon</option>
                                    <option value="WA">Washington</option>
                                </optgroup>
                                <optgroup label="Mountain Time Zone">
                                    <option value="AZ">Arizona</option>
                                    <option value="CO">Colorado</option>
                                    <option value="ID">Idaho</option>
                                    <option value="MT">Montana</option>
                                    <option value="NE">Nebraska</option>
                                    <option value="NM">New Mexico</option>
                                    <option value="ND">North Dakota</option>
                                    <option value="UT">Utah</option>
                                    <option value="WY">Wyoming</option>
                                </optgroup>
                                <optgroup label="Central Time Zone">
                                    <option value="AL">Alabama</option>
                                    <option value="AR">Arkansas</option>
                                    <option value="IL">Illinois</option>
                                    <option value="IA">Iowa</option>
                                    <option value="KS">Kansas</option>
                                    <option value="KY">Kentucky</option>
                                    <option value="LA">Louisiana</option>
                                    <option value="MN">Minnesota</option>
                                    <option value="MS">Mississippi</option>
                                    <option value="MO">Missouri</option>
                                    <option value="OK">Oklahoma</option>
                                    <option value="SD">South Dakota</option>
                                    <option value="TX">Texas</option>
                                    <option value="TN">Tennessee</option>
                                    <option value="WI">Wisconsin</option>
                                </optgroup>
                                <optgroup label="Eastern Time Zone">
                                    <option value="CT">Connecticut</option>
                                    <option value="DE">Delaware</option>
                                    <option value="FL">Florida</option>
                                    <option value="GA">Georgia</option>
                                    <option value="IN">Indiana</option>
                                    <option value="ME">Maine</option>
                                    <option value="MD">Maryland</option>
                                    <option value="MA">Massachusetts</option>
                                    <option value="MI">Michigan</option>
                                    <option value="NH">New Hampshire</option>
                                    <option value="NJ">New Jersey</option>
                                    <option value="NY">New York</option>
                                    <option value="NC">North Carolina</option>
                                    <option value="OH">Ohio</option>
                                    <option value="PA">Pennsylvania</option>
                                    <option value="RI">Rhode Island</option>
                                    <option value="SC">South Carolina</option>
                                    <option value="VT">Vermont</option>
                                    <option value="VA">Virginia</option>
                                    <option value="WV">West Virginia</option>
                                </optgroup>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3 m-t-15">Multiple Select</label>
                        <div class="col-md-9">
                            <select class="select2 form-control m-t-15" multiple="multiple" style="height: 36px;width: 100%;">
                                <optgroup label="Alaskan/Hawaiian Time Zone">
                                    <option value="AK">Alaska</option>
                                    <option value="HI">Hawaii</option>
                                </optgroup>
                                <optgroup label="Pacific Time Zone">
                                    <option value="CA">California</option>
                                    <option value="NV">Nevada</option>
                                    <option value="OR">Oregon</option>
                                    <option value="WA">Washington</option>
                                </optgroup>
                                <optgroup label="Mountain Time Zone">
                                    <option value="AZ">Arizona</option>
                                    <option value="CO">Colorado</option>
                                    <option value="ID">Idaho</option>
                                    <option value="MT">Montana</option>
                                    <option value="NE">Nebraska</option>
                                    <option value="NM" selected>New Mexico</option>
                                    <option value="ND">North Dakota</option>
                                    <option value="UT">Utah</option>
                                    <option value="WY">Wyoming</option>
                                </optgroup>
                                <optgroup label="Central Time Zone">
                                    <option value="AL">Alabama</option>
                                    <option value="AR">Arkansas</option>
                                    <option value="IL">Illinois</option>
                                    <option value="IA">Iowa</option>
                                    <option value="KS">Kansas</option>
                                    <option value="KY">Kentucky</option>
                                    <option value="LA">Louisiana</option>
                                    <option value="MN">Minnesota</option>
                                    <option value="MS">Mississippi</option>
                                    <option value="MO">Missouri</option>
                                    <option value="OK">Oklahoma</option>
                                    <option value="SD" selected>South Dakota</option>
                                    <option value="TX">Texas</option>
                                    <option value="TN">Tennessee</option>
                                    <option value="WI">Wisconsin</option>
                                </optgroup>
                                <optgroup label="Eastern Time Zone">
                                    <option value="CT">Connecticut</option>
                                    <option value="DE">Delaware</option>
                                    <option value="FL">Florida</option>
                                    <option value="GA">Georgia</option>
                                    <option value="IN">Indiana</option>
                                    <option value="ME">Maine</option>
                                    <option value="MD">Maryland</option>
                                    <option value="MA">Massachusetts</option>
                                    <option value="MI">Michigan</option>
                                    <option value="NH">New Hampshire</option>
                                    <option value="NJ">New Jersey</option>
                                    <option value="NY">New York</option>
                                    <option value="NC">North Carolina</option>
                                    <option value="OH">Ohio</option>
                                    <option value="PA">Pennsylvania</option>
                                    <option value="RI">Rhode Island</option>
                                    <option value="SC">South Carolina</option>
                                    <option value="VT">Vermont</option>
                                    <option value="VA">Virginia</option>
                                    <option value="WV">West Virginia</option>
                                </optgroup>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3">Radio Buttons</label>
                        <div class="col-md-9">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" id="customControlValidation1" name="radio-stacked" required>
                                <label class="custom-control-label" for="customControlValidation1">First One</label>
                            </div>
                             <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" id="customControlValidation2" name="radio-stacked" required>
                                <label class="custom-control-label" for="customControlValidation2">Second One</label>
                            </div>
                             <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" id="customControlValidation3" name="radio-stacked" required>
                                <label class="custom-control-label" for="customControlValidation3">Third One</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-md-3">Checkboxes</label>
                        <div class="col-md-9">
                            <div class="custom-control custom-checkbox mr-sm-2">
                                <input type="checkbox" class="custom-control-input" id="customControlAutosizing1">
                                <label class="custom-control-label" for="customControlAutosizing1">First One</label>
                            </div>
                            <div class="custom-control custom-checkbox mr-sm-2">
                                <input type="checkbox" class="custom-control-input" id="customControlAutosizing2">
                                <label class="custom-control-label" for="customControlAutosizing2">Second One</label>
                            </div>
                            <div class="custom-control custom-checkbox mr-sm-2">
                                <input type="checkbox" class="custom-control-input" id="customControlAutosizing3">
                                <label class="custom-control-label" for="customControlAutosizing3">Third One</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3">File Upload</label>
                        <div class="col-md-9">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="validatedCustomFile" required>
                                <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                                <div class="invalid-feedback">Example invalid custom file feedback</div>
                            </div>
                        </div>
                    </div>

		    		<form>
				        <textarea name="content" id="CKEDITOR" rows="8" cols="80"></textarea>
				        <script>
			  				CKEDITOR.replace("content",{  // 라이브러리에서 지원해주는 코드만 써야함(jsp이런거 안됨)
			  					height:480,
				        	  filebrowserUploadUrl:"${ctp}/imageUpload",  /* 파일(이미지)를 업로드 시키기 위한 매핑여로(메소드) */
				        	  uploadUrl : "${ctp}/imageUpload"  	/* uploadUrl : 여러개의 그림 파일을 드래그&드롭해서 올릴수 있다. */
			  				});
				        </script>
		    		</form>
           <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span>Tooltip Input</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <input type="text" data-toggle="tooltip" title="A Tooltip for the input !" class="form-control" id="validationDefault05" placeholder="Hover For tooltip" required>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span>Type Ahead Input</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <input type="text" class="form-control" placeholder="Type here for auto complete.." required>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span>Prepended Input</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">#</span>
                                </div>
                                <input type="text" class="form-control" placeholder="Prepend" aria-label="Username" aria-describedby="basic-addon1">
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span>Appended Input</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="5.000" aria-label="Recipient 's username" aria-describedby="basic-addon2">
                                <div class="input-group-append">
                                    <span class="input-group-text" id="basic-addon2">$</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span class="text-success">Input with Sccess</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <input type="text" class="form-control is-valid" id="validationServer01">
                            <div class="valid-feedback">
                                Woohoo!
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-lg-4 col-md-12 text-right">
                            <span class="text-danger">Input with Error</span>
                        </div>
                        <div class="col-lg-8 col-md-12">
                            <input type="text" class="form-control is-invalid" id="validationServer01">
                            <div class="invalid-feedback">
                                Please correct the error
                            </div>
                        </div>
                    </div>
                </div>
                <div class="border-top">
                    <div class="card-body">
                        <button type="button" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </div>
		</div>
	</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
<script>
( function( $ ) {

	$.fn.multicheck = function( $checkboxes ) {
		$checkboxes = $checkboxes.filter( 'input[type=checkbox]' );
		if( $checkboxes.length > 0 ) {
			this.each( function() {
				var $this = $( this );
				$this.click( function() {
					$checkboxes.prop( 'checked', this.checked );
					$this.trigger( this.checked ? 'multicheck.allchecked' : 'multicheck.nonechecked' );
				});
				$checkboxes.on( 'click change', function() {
					var checkedItems = $checkboxes.filter( ':checked' ).length;
					if( checkedItems == 0 ) {
						$this[ 0 ].indeterminate = false;
						$this[ 0 ].checked = false;
						$this.trigger( 'multicheck.nonechecked' );
					} else if( checkedItems == $checkboxes.length ) {
						$this[ 0 ].indeterminate = false;
						$this[ 0 ].checked = true;
						$this.trigger( 'multicheck.allchecked' );
					} else {
						$this[ 0 ].checked = false;
						$this[ 0 ].indeterminate = true;
						$this.trigger( 'multicheck.somechecked' );
					}
				});
			});
		}
		return this;
	};

})( jQuery );
/*! Select2 4.0.6-rc.1 | https://github.com/select2/select2/blob/master/LICENSE.md */!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof module&&module.exports?module.exports=function(b,c){return void 0===c&&(c="undefined"!=typeof window?require("jquery"):require("jquery")(b)),a(c),c}:a(jQuery)}(function(a){var b=function(){if(a&&a.fn&&a.fn.select2&&a.fn.select2.amd)var b=a.fn.select2.amd;var b;return function(){if(!b||!b.requirejs){b?c=b:b={};var a,c,d;!function(b){function e(a,b){return v.call(a,b)}function f(a,b){var c,d,e,f,g,h,i,j,k,l,m,n,o=b&&b.split("/"),p=t.map,q=p&&p["*"]||{};if(a){for(a=a.split("/"),g=a.length-1,t.nodeIdCompat&&x.test(a[g])&&(a[g]=a[g].replace(x,"")),"."===a[0].charAt(0)&&o&&(n=o.slice(0,o.length-1),a=n.concat(a)),k=0;k<a.length;k++)if("."===(m=a[k]))a.splice(k,1),k-=1;else if(".."===m){if(0===k||1===k&&".."===a[2]||".."===a[k-1])continue;k>0&&(a.splice(k-1,2),k-=2)}a=a.join("/")}if((o||q)&&p){for(c=a.split("/"),k=c.length;k>0;k-=1){if(d=c.slice(0,k).join("/"),o)for(l=o.length;l>0;l-=1)if((e=p[o.slice(0,l).join("/")])&&(e=e[d])){f=e,h=k;break}if(f)break;!i&&q&&q[d]&&(i=q[d],j=k)}!f&&i&&(f=i,h=j),f&&(c.splice(0,h,f),a=c.join("/"))}return a}function g(a,c){return function(){var d=w.call(arguments,0);return"string"!=typeof d[0]&&1===d.length&&d.push(null),o.apply(b,d.concat([a,c]))}}function h(a){return function(b){return f(b,a)}}function i(a){return function(b){r[a]=b}}function j(a){if(e(s,a)){var c=s[a];delete s[a],u[a]=!0,n.apply(b,c)}if(!e(r,a)&&!e(u,a))throw new Error("No "+a);return r[a]}function k(a){var b,c=a?a.indexOf("!"):-1;return c>-1&&(b=a.substring(0,c),a=a.substring(c+1,a.length)),[b,a]}function l(a){return a?k(a):[]}function m(a){return function(){return t&&t.config&&t.config[a]||{}}}var n,o,p,q,r={},s={},t={},u={},v=Object.prototype.hasOwnProperty,w=[].slice,x=/\.js$/;p=function(a,b){var c,d=k(a),e=d[0],g=b[1];return a=d[1],e&&(e=f(e,g),c=j(e)),e?a=c&&c.normalize?c.normalize(a,h(g)):f(a,g):(a=f(a,g),d=k(a),e=d[0],a=d[1],e&&(c=j(e))),{f:e?e+"!"+a:a,n:a,pr:e,p:c}},q={require:function(a){return g(a)},exports:function(a){var b=r[a];return void 0!==b?b:r[a]={}},module:function(a){return{id:a,uri:"",exports:r[a],config:m(a)}}},n=function(a,c,d,f){var h,k,m,n,o,t,v,w=[],x=typeof d;if(f=f||a,t=l(f),"undefined"===x||"function"===x){for(c=!c.length&&d.length?["require","exports","module"]:c,o=0;o<c.length;o+=1)if(n=p(c[o],t),"require"===(k=n.f))w[o]=q.require(a);else if("exports"===k)w[o]=q.exports(a),v=!0;else if("module"===k)h=w[o]=q.module(a);else if(e(r,k)||e(s,k)||e(u,k))w[o]=j(k);else{if(!n.p)throw new Error(a+" missing "+k);n.p.load(n.n,g(f,!0),i(k),{}),w[o]=r[k]}m=d?d.apply(r[a],w):void 0,a&&(h&&h.exports!==b&&h.exports!==r[a]?r[a]=h.exports:m===b&&v||(r[a]=m))}else a&&(r[a]=d)},a=c=o=function(a,c,d,e,f){if("string"==typeof a)return q[a]?q[a](c):j(p(a,l(c)).f);if(!a.splice){if(t=a,t.deps&&o(t.deps,t.callback),!c)return;c.splice?(a=c,c=d,d=null):a=b}return c=c||function(){},"function"==typeof d&&(d=e,e=f),e?n(b,a,c,d):setTimeout(function(){n(b,a,c,d)},4),o},o.config=function(a){return o(a)},a._defined=r,d=function(a,b,c){if("string"!=typeof a)throw new Error("See almond README: incorrect module build, no module name");b.splice||(c=b,b=[]),e(r,a)||e(s,a)||(s[a]=[a,b,c])},d.amd={jQuery:!0}}(),b.requirejs=a,b.require=c,b.define=d}}(),b.define("almond",function(){}),b.define("jquery",[],function(){var b=a||$;return null==b&&console&&console.error&&console.error("Select2: An instance of jQuery or a jQuery-compatible library was not found. Make sure that you are including jQuery before Select2 on your web page."),b}),b.define("select2/utils",["jquery"],function(a){function b(a){var b=a.prototype,c=[];for(var d in b){"function"==typeof b[d]&&("constructor"!==d&&c.push(d))}return c}var c={};c.Extend=function(a,b){function c(){this.constructor=a}var d={}.hasOwnProperty;for(var e in b)d.call(b,e)&&(a[e]=b[e]);return c.prototype=b.prototype,a.prototype=new c,a.__super__=b.prototype,a},c.Decorate=function(a,c){function d(){var b=Array.prototype.unshift,d=c.prototype.constructor.length,e=a.prototype.constructor;d>0&&(b.call(arguments,a.prototype.constructor),e=c.prototype.constructor),e.apply(this,arguments)}function e(){this.constructor=d}var f=b(c),g=b(a);c.displayName=a.displayName,d.prototype=new e;for(var h=0;h<g.length;h++){var i=g[h];d.prototype[i]=a.prototype[i]}for(var j=(function(a){var b=function(){};a in d.prototype&&(b=d.prototype[a]);var e=c.prototype[a];return function(){return Array.prototype.unshift.call(arguments,b),e.apply(this,arguments)}}),k=0;k<f.length;k++){var l=f[k];d.prototype[l]=j(l)}return d};var d=function(){this.listeners={}};d.prototype.on=function(a,b){this.listeners=this.listeners||{},a in this.listeners?this.listeners[a].push(b):this.listeners[a]=[b]},d.prototype.trigger=function(a){var b=Array.prototype.slice,c=b.call(arguments,1);this.listeners=this.listeners||{},null==c&&(c=[]),0===c.length&&c.push({}),c[0]._type=a,a in this.listeners&&this.invoke(this.listeners[a],b.call(arguments,1)),"*"in this.listeners&&this.invoke(this.listeners["*"],arguments)},d.prototype.invoke=function(a,b){for(var c=0,d=a.length;c<d;c++)a[c].apply(this,b)},c.Observable=d,c.generateChars=function(a){for(var b="",c=0;c<a;c++){b+=Math.floor(36*Math.random()).toString(36)}return b},c.bind=function(a,b){return function(){a.apply(b,arguments)}},c._convertData=function(a){for(var b in a){var c=b.split("-"),d=a;if(1!==c.length){for(var e=0;e<c.length;e++){var f=c[e];f=f.substring(0,1).toLowerCase()+f.substring(1),f in d||(d[f]={}),e==c.length-1&&(d[f]=a[b]),d=d[f]}delete a[b]}}return a},c.hasScroll=function(b,c){var d=a(c),e=c.style.overflowX,f=c.style.overflowY;return(e!==f||"hidden"!==f&&"visible"!==f)&&("scroll"===e||"scroll"===f||(d.innerHeight()<c.scrollHeight||d.innerWidth()<c.scrollWidth))},c.escapeMarkup=function(a){var b={"\\":"&#92;","&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;","/":"&#47;"};return"string"!=typeof a?a:String(a).replace(/[&<>"'\/\\]/g,function(a){return b[a]})},c.appendMany=function(b,c){if("1.7"===a.fn.jquery.substr(0,3)){var d=a();a.map(c,function(a){d=d.add(a)}),c=d}b.append(c)},c.__cache={};var e=0;return c.GetUniqueElementId=function(a){var b=a.getAttribute("data-select2-id");return null==b&&(a.id?(b=a.id,a.setAttribute("data-select2-id",b)):(a.setAttribute("data-select2-id",++e),b=e.toString())),b},c.StoreData=function(a,b,d){var e=c.GetUniqueElementId(a);c.__cache[e]||(c.__cache[e]={}),c.__cache[e][b]=d},c.GetData=function(b,d){var e=c.GetUniqueElementId(b);return d?c.__cache[e]&&null!=c.__cache[e][d]?c.__cache[e][d]:a(b).data(d):c.__cache[e]},c.RemoveData=function(a){var b=c.GetUniqueElementId(a);null!=c.__cache[b]&&delete c.__cache[b]},c}),b.define("select2/results",["jquery","./utils"],function(a,b){function c(a,b,d){this.$element=a,this.data=d,this.options=b,c.__super__.constructor.call(this)}return b.Extend(c,b.Observable),c.prototype.render=function(){var b=a('<ul class="select2-results__options" role="tree"></ul>');return this.options.get("multiple")&&b.attr("aria-multiselectable","true"),this.$results=b,b},c.prototype.clear=function(){this.$results.empty()},c.prototype.displayMessage=function(b){var c=this.options.get("escapeMarkup");this.clear(),this.hideLoading();var d=a('<li role="treeitem" aria-live="assertive" class="select2-results__option"></li>'),e=this.options.get("translations").get(b.message);d.append(c(e(b.args))),d[0].className+=" select2-results__message",this.$results.append(d)},c.prototype.hideMessages=function(){this.$results.find(".select2-results__message").remove()},c.prototype.append=function(a){this.hideLoading();var b=[];if(null==a.results||0===a.results.length)return void(0===this.$results.children().length&&this.trigger("results:message",{message:"noResults"}));a.results=this.sort(a.results);for(var c=0;c<a.results.length;c++){var d=a.results[c],e=this.option(d);b.push(e)}this.$results.append(b)},c.prototype.position=function(a,b){b.find(".select2-results").append(a)},c.prototype.sort=function(a){return this.options.get("sorter")(a)},c.prototype.highlightFirstItem=function(){var a=this.$results.find(".select2-results__option[aria-selected]"),b=a.filter("[aria-selected=true]");b.length>0?b.first().trigger("mouseenter"):a.first().trigger("mouseenter"),this.ensureHighlightVisible()},c.prototype.setClasses=function(){var c=this;this.data.current(function(d){var e=a.map(d,function(a){return a.id.toString()});c.$results.find(".select2-results__option[aria-selected]").each(function(){var c=a(this),d=b.GetData(this,"data"),f=""+d.id;null!=d.element&&d.element.selected||null==d.element&&a.inArray(f,e)>-1?c.attr("aria-selected","true"):c.attr("aria-selected","false")})})},c.prototype.showLoading=function(a){this.hideLoading();var b=this.options.get("translations").get("searching"),c={disabled:!0,loading:!0,text:b(a)},d=this.option(c);d.className+=" loading-results",this.$results.prepend(d)},c.prototype.hideLoading=function(){this.$results.find(".loading-results").remove()},c.prototype.option=function(c){var d=document.createElement("li");d.className="select2-results__option";var e={role:"treeitem","aria-selected":"false"};c.disabled&&(delete e["aria-selected"],e["aria-disabled"]="true"),null==c.id&&delete e["aria-selected"],null!=c._resultId&&(d.id=c._resultId),c.title&&(d.title=c.title),c.children&&(e.role="group",e["aria-label"]=c.text,delete e["aria-selected"]);for(var f in e){var g=e[f];d.setAttribute(f,g)}if(c.children){var h=a(d),i=document.createElement("strong");i.className="select2-results__group";a(i);this.template(c,i);for(var j=[],k=0;k<c.children.length;k++){var l=c.children[k],m=this.option(l);j.push(m)}var n=a("<ul></ul>",{class:"select2-results__options select2-results__options--nested"});n.append(j),h.append(i),h.append(n)}else this.template(c,d);return b.StoreData(d,"data",c),d},c.prototype.bind=function(c,d){var e=this,f=c.id+"-results";this.$results.attr("id",f),c.on("results:all",function(a){e.clear(),e.append(a.data),c.isOpen()&&(e.setClasses(),e.highlightFirstItem())}),c.on("results:append",function(a){e.append(a.data),c.isOpen()&&e.setClasses()}),c.on("query",function(a){e.hideMessages(),e.showLoading(a)}),c.on("select",function(){c.isOpen()&&(e.setClasses(),e.highlightFirstItem())}),c.on("unselect",function(){c.isOpen()&&(e.setClasses(),e.highlightFirstItem())}),c.on("open",function(){e.$results.attr("aria-expanded","true"),e.$results.attr("aria-hidden","false"),e.setClasses(),e.ensureHighlightVisible()}),c.on("close",function(){e.$results.attr("aria-expanded","false"),e.$results.attr("aria-hidden","true"),e.$results.removeAttr("aria-activedescendant")}),c.on("results:toggle",function(){var a=e.getHighlightedResults();0!==a.length&&a.trigger("mouseup")}),c.on("results:select",function(){var a=e.getHighlightedResults();if(0!==a.length){var c=b.GetData(a[0],"data");"true"==a.attr("aria-selected")?e.trigger("close",{}):e.trigger("select",{data:c})}}),c.on("results:previous",function(){var a=e.getHighlightedResults(),b=e.$results.find("[aria-selected]"),c=b.index(a);if(!(c<=0)){var d=c-1;0===a.length&&(d=0);var f=b.eq(d);f.trigger("mouseenter");var g=e.$results.offset().top,h=f.offset().top,i=e.$results.scrollTop()+(h-g);0===d?e.$results.scrollTop(0):h-g<0&&e.$results.scrollTop(i)}}),c.on("results:next",function(){var a=e.getHighlightedResults(),b=e.$results.find("[aria-selected]"),c=b.index(a),d=c+1;if(!(d>=b.length)){var f=b.eq(d);f.trigger("mouseenter");var g=e.$results.offset().top+e.$results.outerHeight(!1),h=f.offset().top+f.outerHeight(!1),i=e.$results.scrollTop()+h-g;0===d?e.$results.scrollTop(0):h>g&&e.$results.scrollTop(i)}}),c.on("results:focus",function(a){a.element.addClass("select2-results__option--highlighted")}),c.on("results:message",function(a){e.displayMessage(a)}),a.fn.mousewheel&&this.$results.on("mousewheel",function(a){var b=e.$results.scrollTop(),c=e.$results.get(0).scrollHeight-b+a.deltaY,d=a.deltaY>0&&b-a.deltaY<=0,f=a.deltaY<0&&c<=e.$results.height();d?(e.$results.scrollTop(0),a.preventDefault(),a.stopPropagation()):f&&(e.$results.scrollTop(e.$results.get(0).scrollHeight-e.$results.height()),a.preventDefault(),a.stopPropagation())}),this.$results.on("mouseup",".select2-results__option[aria-selected]",function(c){var d=a(this),f=b.GetData(this,"data");if("true"===d.attr("aria-selected"))return void(e.options.get("multiple")?e.trigger("unselect",{originalEvent:c,data:f}):e.trigger("close",{}));e.trigger("select",{originalEvent:c,data:f})}),this.$results.on("mouseenter",".select2-results__option[aria-selected]",function(c){var d=b.GetData(this,"data");e.getHighlightedResults().removeClass("select2-results__option--highlighted"),e.trigger("results:focus",{data:d,element:a(this)})})},c.prototype.getHighlightedResults=function(){return this.$results.find(".select2-results__option--highlighted")},c.prototype.destroy=function(){this.$results.remove()},c.prototype.ensureHighlightVisible=function(){var a=this.getHighlightedResults();if(0!==a.length){var b=this.$results.find("[aria-selected]"),c=b.index(a),d=this.$results.offset().top,e=a.offset().top,f=this.$results.scrollTop()+(e-d),g=e-d;f-=2*a.outerHeight(!1),c<=2?this.$results.scrollTop(0):(g>this.$results.outerHeight()||g<0)&&this.$results.scrollTop(f)}},c.prototype.template=function(b,c){var d=this.options.get("templateResult"),e=this.options.get("escapeMarkup"),f=d(b,c);null==f?c.style.display="none":"string"==typeof f?c.innerHTML=e(f):a(c).append(f)},c}),b.define("select2/keys",[],function(){return{BACKSPACE:8,TAB:9,ENTER:13,SHIFT:16,CTRL:17,ALT:18,ESC:27,SPACE:32,PAGE_UP:33,PAGE_DOWN:34,END:35,HOME:36,LEFT:37,UP:38,RIGHT:39,DOWN:40,DELETE:46}}),b.define("select2/selection/base",["jquery","../utils","../keys"],function(a,b,c){function d(a,b){this.$element=a,this.options=b,d.__super__.constructor.call(this)}return b.Extend(d,b.Observable),d.prototype.render=function(){var c=a('<span class="select2-selection" role="combobox"  aria-haspopup="true" aria-expanded="false"></span>');return this._tabindex=0,null!=b.GetData(this.$element[0],"old-tabindex")?this._tabindex=b.GetData(this.$element[0],"old-tabindex"):null!=this.$element.attr("tabindex")&&(this._tabindex=this.$element.attr("tabindex")),c.attr("title",this.$element.attr("title")),c.attr("tabindex",this._tabindex),this.$selection=c,c},d.prototype.bind=function(a,b){var d=this,e=(a.id,a.id+"-results");this.container=a,this.$selection.on("focus",function(a){d.trigger("focus",a)}),this.$selection.on("blur",function(a){d._handleBlur(a)}),this.$selection.on("keydown",function(a){d.trigger("keypress",a),a.which===c.SPACE&&a.preventDefault()}),a.on("results:focus",function(a){d.$selection.attr("aria-activedescendant",a.data._resultId)}),a.on("selection:update",function(a){d.update(a.data)}),a.on("open",function(){d.$selection.attr("aria-expanded","true"),d.$selection.attr("aria-owns",e),d._attachCloseHandler(a)}),a.on("close",function(){d.$selection.attr("aria-expanded","false"),d.$selection.removeAttr("aria-activedescendant"),d.$selection.removeAttr("aria-owns"),d.$selection.focus(),window.setTimeout(function(){d.$selection.focus()},0),d._detachCloseHandler(a)}),a.on("enable",function(){d.$selection.attr("tabindex",d._tabindex)}),a.on("disable",function(){d.$selection.attr("tabindex","-1")})},d.prototype._handleBlur=function(b){var c=this;window.setTimeout(function(){document.activeElement==c.$selection[0]||a.contains(c.$selection[0],document.activeElement)||c.trigger("blur",b)},1)},d.prototype._attachCloseHandler=function(c){a(document.body).on("mousedown.select2."+c.id,function(c){var d=a(c.target),e=d.closest(".select2");a(".select2.select2-container--open").each(function(){a(this),this!=e[0]&&b.GetData(this,"element").select2("close")})})},d.prototype._detachCloseHandler=function(b){a(document.body).off("mousedown.select2."+b.id)},d.prototype.position=function(a,b){b.find(".selection").append(a)},d.prototype.destroy=function(){this._detachCloseHandler(this.container)},d.prototype.update=function(a){throw new Error("The `update` method must be defined in child classes.")},d}),b.define("select2/selection/single",["jquery","./base","../utils","../keys"],function(a,b,c,d){function e(){e.__super__.constructor.apply(this,arguments)}return c.Extend(e,b),e.prototype.render=function(){var a=e.__super__.render.call(this);return a.addClass("select2-selection--single"),a.html('<span class="select2-selection__rendered"></span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span>'),a},e.prototype.bind=function(a,b){var c=this;e.__super__.bind.apply(this,arguments);var d=a.id+"-container";this.$selection.find(".select2-selection__rendered").attr("id",d).attr("role","textbox").attr("aria-readonly","true"),this.$selection.attr("aria-labelledby",d),this.$selection.on("mousedown",function(a){1===a.which&&c.trigger("toggle",{originalEvent:a})}),this.$selection.on("focus",function(a){}),this.$selection.on("blur",function(a){}),a.on("focus",function(b){a.isOpen()||c.$selection.focus()})},e.prototype.clear=function(){var a=this.$selection.find(".select2-selection__rendered");a.empty(),a.removeAttr("title")},e.prototype.display=function(a,b){var c=this.options.get("templateSelection");return this.options.get("escapeMarkup")(c(a,b))},e.prototype.selectionContainer=function(){return a("<span></span>")},e.prototype.update=function(a){if(0===a.length)return void this.clear();var b=a[0],c=this.$selection.find(".select2-selection__rendered"),d=this.display(b,c);c.empty().append(d),c.attr("title",b.title||b.text)},e}),b.define("select2/selection/multiple",["jquery","./base","../utils"],function(a,b,c){function d(a,b){d.__super__.constructor.apply(this,arguments)}return c.Extend(d,b),d.prototype.render=function(){var a=d.__super__.render.call(this);return a.addClass("select2-selection--multiple"),a.html('<ul class="select2-selection__rendered"></ul>'),a},d.prototype.bind=function(b,e){var f=this;d.__super__.bind.apply(this,arguments),this.$selection.on("click",function(a){f.trigger("toggle",{originalEvent:a})}),this.$selection.on("click",".select2-selection__choice__remove",function(b){if(!f.options.get("disabled")){var d=a(this),e=d.parent(),g=c.GetData(e[0],"data");f.trigger("unselect",{originalEvent:b,data:g})}})},d.prototype.clear=function(){var a=this.$selection.find(".select2-selection__rendered");a.empty(),a.removeAttr("title")},d.prototype.display=function(a,b){var c=this.options.get("templateSelection");return this.options.get("escapeMarkup")(c(a,b))},d.prototype.selectionContainer=function(){return a('<li class="select2-selection__choice"><span class="select2-selection__choice__remove" role="presentation">&times;</span></li>')},d.prototype.update=function(a){if(this.clear(),0!==a.length){for(var b=[],d=0;d<a.length;d++){var e=a[d],f=this.selectionContainer(),g=this.display(e,f);f.append(g),f.attr("title",e.title||e.text),c.StoreData(f[0],"data",e),b.push(f)}var h=this.$selection.find(".select2-selection__rendered");c.appendMany(h,b)}},d}),b.define("select2/selection/placeholder",["../utils"],function(a){function b(a,b,c){this.placeholder=this.normalizePlaceholder(c.get("placeholder")),a.call(this,b,c)}return b.prototype.normalizePlaceholder=function(a,b){return"string"==typeof b&&(b={id:"",text:b}),b},b.prototype.createPlaceholder=function(a,b){var c=this.selectionContainer();return c.html(this.display(b)),c.addClass("select2-selection__placeholder").removeClass("select2-selection__choice"),c},b.prototype.update=function(a,b){var c=1==b.length&&b[0].id!=this.placeholder.id;if(b.length>1||c)return a.call(this,b);this.clear();var d=this.createPlaceholder(this.placeholder);this.$selection.find(".select2-selection__rendered").append(d)},b}),b.define("select2/selection/allowClear",["jquery","../keys","../utils"],function(a,b,c){function d(){}return d.prototype.bind=function(a,b,c){var d=this;a.call(this,b,c),null==this.placeholder&&this.options.get("debug")&&window.console&&console.error&&console.error("Select2: The `allowClear` option should be used in combination with the `placeholder` option."),this.$selection.on("mousedown",".select2-selection__clear",function(a){d._handleClear(a)}),b.on("keypress",function(a){d._handleKeyboardClear(a,b)})},d.prototype._handleClear=function(a,b){if(!this.options.get("disabled")){var d=this.$selection.find(".select2-selection__clear");if(0!==d.length){b.stopPropagation();var e=c.GetData(d[0],"data"),f=this.$element.val();this.$element.val(this.placeholder.id);var g={data:e};if(this.trigger("clear",g),g.prevented)return void this.$element.val(f);for(var h=0;h<e.length;h++)if(g={data:e[h]},this.trigger("unselect",g),g.prevented)return void this.$element.val(f);this.$element.trigger("change"),this.trigger("toggle",{})}}},d.prototype._handleKeyboardClear=function(a,c,d){d.isOpen()||c.which!=b.DELETE&&c.which!=b.BACKSPACE||this._handleClear(c)},d.prototype.update=function(b,d){if(b.call(this,d),!(this.$selection.find(".select2-selection__placeholder").length>0||0===d.length)){var e=a('<span class="select2-selection__clear">&times;</span>');c.StoreData(e[0],"data",d),this.$selection.find(".select2-selection__rendered").prepend(e)}},d}),b.define("select2/selection/search",["jquery","../utils","../keys"],function(a,b,c){function d(a,b,c){a.call(this,b,c)}return d.prototype.render=function(b){var c=a('<li class="select2-search select2-search--inline"><input class="select2-search__field" type="search" tabindex="-1" autocomplete="off" autocorrect="off" autocapitalize="none" spellcheck="false" role="textbox" aria-autocomplete="list" /></li>');this.$searchContainer=c,this.$search=c.find("input");var d=b.call(this);return this._transferTabIndex(),d},d.prototype.bind=function(a,d,e){var f=this;a.call(this,d,e),d.on("open",function(){f.$search.trigger("focus")}),d.on("close",function(){f.$search.val(""),f.$search.removeAttr("aria-activedescendant"),f.$search.trigger("focus")}),d.on("enable",function(){f.$search.prop("disabled",!1),f._transferTabIndex()}),d.on("disable",function(){f.$search.prop("disabled",!0)}),d.on("focus",function(a){f.$search.trigger("focus")}),d.on("results:focus",function(a){f.$search.attr("aria-activedescendant",a.id)}),this.$selection.on("focusin",".select2-search--inline",function(a){f.trigger("focus",a)}),this.$selection.on("focusout",".select2-search--inline",function(a){f._handleBlur(a)}),this.$selection.on("keydown",".select2-search--inline",function(a){if(a.stopPropagation(),f.trigger("keypress",a),f._keyUpPrevented=a.isDefaultPrevented(),a.which===c.BACKSPACE&&""===f.$search.val()){var d=f.$searchContainer.prev(".select2-selection__choice");if(d.length>0){var e=b.GetData(d[0],"data");f.searchRemoveChoice(e),a.preventDefault()}}});var g=document.documentMode,h=g&&g<=11;this.$selection.on("input.searchcheck",".select2-search--inline",function(a){if(h)return void f.$selection.off("input.search input.searchcheck");f.$selection.off("keyup.search")}),this.$selection.on("keyup.search input.search",".select2-search--inline",function(a){if(h&&"input"===a.type)return void f.$selection.off("input.search input.searchcheck");var b=a.which;b!=c.SHIFT&&b!=c.CTRL&&b!=c.ALT&&b!=c.TAB&&f.handleSearch(a)})},d.prototype._transferTabIndex=function(a){this.$search.attr("tabindex",this.$selection.attr("tabindex")),this.$selection.attr("tabindex","-1")},d.prototype.createPlaceholder=function(a,b){this.$search.attr("placeholder",b.text)},d.prototype.update=function(a,b){var c=this.$search[0]==document.activeElement;if(this.$search.attr("placeholder",""),a.call(this,b),this.$selection.find(".select2-selection__rendered").append(this.$searchContainer),this.resizeSearch(),c){this.$element.find("[data-select2-tag]").length?this.$element.focus():this.$search.focus()}},d.prototype.handleSearch=function(){if(this.resizeSearch(),!this._keyUpPrevented){var a=this.$search.val();this.trigger("query",{term:a})}this._keyUpPrevented=!1},d.prototype.searchRemoveChoice=function(a,b){this.trigger("unselect",{data:b}),this.$search.val(b.text),this.handleSearch()},d.prototype.resizeSearch=function(){this.$search.css("width","25px");var a="";if(""!==this.$search.attr("placeholder"))a=this.$selection.find(".select2-selection__rendered").innerWidth();else{a=.75*(this.$search.val().length+1)+"em"}this.$search.css("width",a)},d}),b.define("select2/selection/eventRelay",["jquery"],function(a){function b(){}return b.prototype.bind=function(b,c,d){var e=this,f=["open","opening","close","closing","select","selecting","unselect","unselecting","clear","clearing"],g=["opening","closing","selecting","unselecting","clearing"];b.call(this,c,d),c.on("*",function(b,c){if(-1!==a.inArray(b,f)){c=c||{};var d=a.Event("select2:"+b,{params:c});e.$element.trigger(d),-1!==a.inArray(b,g)&&(c.prevented=d.isDefaultPrevented())}})},b}),b.define("select2/translation",["jquery","require"],function(a,b){function c(a){this.dict=a||{}}return c.prototype.all=function(){return this.dict},c.prototype.get=function(a){return this.dict[a]},c.prototype.extend=function(b){this.dict=a.extend({},b.all(),this.dict)},c._cache={},c.loadPath=function(a){if(!(a in c._cache)){var d=b(a);c._cache[a]=d}return new c(c._cache[a])},c}),b.define("select2/diacritics",[],function(){return{"Ⓐ":"A","Ａ":"A","À":"A","Á":"A","Â":"A","Ầ":"A","Ấ":"A","Ẫ":"A","Ẩ":"A","Ã":"A","Ā":"A","Ă":"A","Ằ":"A","Ắ":"A","Ẵ":"A","Ẳ":"A","Ȧ":"A","Ǡ":"A","Ä":"A","Ǟ":"A","Ả":"A","Å":"A","Ǻ":"A","Ǎ":"A","Ȁ":"A","Ȃ":"A","Ạ":"A","Ậ":"A","Ặ":"A","Ḁ":"A","Ą":"A","Ⱥ":"A","Ɐ":"A","Ꜳ":"AA","Æ":"AE","Ǽ":"AE","Ǣ":"AE","Ꜵ":"AO","Ꜷ":"AU","Ꜹ":"AV","Ꜻ":"AV","Ꜽ":"AY","Ⓑ":"B","Ｂ":"B","Ḃ":"B","Ḅ":"B","Ḇ":"B","Ƀ":"B","Ƃ":"B","Ɓ":"B","Ⓒ":"C","Ｃ":"C","Ć":"C","Ĉ":"C","Ċ":"C","Č":"C","Ç":"C","Ḉ":"C","Ƈ":"C","Ȼ":"C","Ꜿ":"C","Ⓓ":"D","Ｄ":"D","Ḋ":"D","Ď":"D","Ḍ":"D","Ḑ":"D","Ḓ":"D","Ḏ":"D","Đ":"D","Ƌ":"D","Ɗ":"D","Ɖ":"D","Ꝺ":"D","Ǳ":"DZ","Ǆ":"DZ","ǲ":"Dz","ǅ":"Dz","Ⓔ":"E","Ｅ":"E","È":"E","É":"E","Ê":"E","Ề":"E","Ế":"E","Ễ":"E","Ể":"E","Ẽ":"E","Ē":"E","Ḕ":"E","Ḗ":"E","Ĕ":"E","Ė":"E","Ë":"E","Ẻ":"E","Ě":"E","Ȅ":"E","Ȇ":"E","Ẹ":"E","Ệ":"E","Ȩ":"E","Ḝ":"E","Ę":"E","Ḙ":"E","Ḛ":"E","Ɛ":"E","Ǝ":"E","Ⓕ":"F","Ｆ":"F","Ḟ":"F","Ƒ":"F","Ꝼ":"F","Ⓖ":"G","Ｇ":"G","Ǵ":"G","Ĝ":"G","Ḡ":"G","Ğ":"G","Ġ":"G","Ǧ":"G","Ģ":"G","Ǥ":"G","Ɠ":"G","Ꞡ":"G","Ᵹ":"G","Ꝿ":"G","Ⓗ":"H","Ｈ":"H","Ĥ":"H","Ḣ":"H","Ḧ":"H","Ȟ":"H","Ḥ":"H","Ḩ":"H","Ḫ":"H","Ħ":"H","Ⱨ":"H","Ⱶ":"H","Ɥ":"H","Ⓘ":"I","Ｉ":"I","Ì":"I","Í":"I","Î":"I","Ĩ":"I","Ī":"I","Ĭ":"I","İ":"I","Ï":"I","Ḯ":"I","Ỉ":"I","Ǐ":"I","Ȉ":"I","Ȋ":"I","Ị":"I","Į":"I","Ḭ":"I","Ɨ":"I","Ⓙ":"J","Ｊ":"J","Ĵ":"J","Ɉ":"J","Ⓚ":"K","Ｋ":"K","Ḱ":"K","Ǩ":"K","Ḳ":"K","Ķ":"K","Ḵ":"K","Ƙ":"K","Ⱪ":"K","Ꝁ":"K","Ꝃ":"K","Ꝅ":"K","Ꞣ":"K","Ⓛ":"L","Ｌ":"L","Ŀ":"L","Ĺ":"L","Ľ":"L","Ḷ":"L","Ḹ":"L","Ļ":"L","Ḽ":"L","Ḻ":"L","Ł":"L","Ƚ":"L","Ɫ":"L","Ⱡ":"L","Ꝉ":"L","Ꝇ":"L","Ꞁ":"L","Ǉ":"LJ","ǈ":"Lj","Ⓜ":"M","Ｍ":"M","Ḿ":"M","Ṁ":"M","Ṃ":"M","Ɱ":"M","Ɯ":"M","Ⓝ":"N","Ｎ":"N","Ǹ":"N","Ń":"N","Ñ":"N","Ṅ":"N","Ň":"N","Ṇ":"N","Ņ":"N","Ṋ":"N","Ṉ":"N","Ƞ":"N","Ɲ":"N","Ꞑ":"N","Ꞥ":"N","Ǌ":"NJ","ǋ":"Nj","Ⓞ":"O","Ｏ":"O","Ò":"O","Ó":"O","Ô":"O","Ồ":"O","Ố":"O","Ỗ":"O","Ổ":"O","Õ":"O","Ṍ":"O","Ȭ":"O","Ṏ":"O","Ō":"O","Ṑ":"O","Ṓ":"O","Ŏ":"O","Ȯ":"O","Ȱ":"O","Ö":"O","Ȫ":"O","Ỏ":"O","Ő":"O","Ǒ":"O","Ȍ":"O","Ȏ":"O","Ơ":"O","Ờ":"O","Ớ":"O","Ỡ":"O","Ở":"O","Ợ":"O","Ọ":"O","Ộ":"O","Ǫ":"O","Ǭ":"O","Ø":"O","Ǿ":"O","Ɔ":"O","Ɵ":"O","Ꝋ":"O","Ꝍ":"O","Ƣ":"OI","Ꝏ":"OO","Ȣ":"OU","Ⓟ":"P","Ｐ":"P","Ṕ":"P","Ṗ":"P","Ƥ":"P","Ᵽ":"P","Ꝑ":"P","Ꝓ":"P","Ꝕ":"P","Ⓠ":"Q","Ｑ":"Q","Ꝗ":"Q","Ꝙ":"Q","Ɋ":"Q","Ⓡ":"R","Ｒ":"R","Ŕ":"R","Ṙ":"R","Ř":"R","Ȑ":"R","Ȓ":"R","Ṛ":"R","Ṝ":"R","Ŗ":"R","Ṟ":"R","Ɍ":"R","Ɽ":"R","Ꝛ":"R","Ꞧ":"R","Ꞃ":"R","Ⓢ":"S","Ｓ":"S","ẞ":"S","Ś":"S","Ṥ":"S","Ŝ":"S","Ṡ":"S","Š":"S","Ṧ":"S","Ṣ":"S","Ṩ":"S","Ș":"S","Ş":"S","Ȿ":"S","Ꞩ":"S","Ꞅ":"S","Ⓣ":"T","Ｔ":"T","Ṫ":"T","Ť":"T","Ṭ":"T","Ț":"T","Ţ":"T","Ṱ":"T","Ṯ":"T","Ŧ":"T","Ƭ":"T","Ʈ":"T","Ⱦ":"T","Ꞇ":"T","Ꜩ":"TZ","Ⓤ":"U","Ｕ":"U","Ù":"U","Ú":"U","Û":"U","Ũ":"U","Ṹ":"U","Ū":"U","Ṻ":"U","Ŭ":"U","Ü":"U","Ǜ":"U","Ǘ":"U","Ǖ":"U","Ǚ":"U","Ủ":"U","Ů":"U","Ű":"U","Ǔ":"U","Ȕ":"U","Ȗ":"U","Ư":"U","Ừ":"U","Ứ":"U","Ữ":"U","Ử":"U","Ự":"U","Ụ":"U","Ṳ":"U","Ų":"U","Ṷ":"U","Ṵ":"U","Ʉ":"U","Ⓥ":"V","Ｖ":"V","Ṽ":"V","Ṿ":"V","Ʋ":"V","Ꝟ":"V","Ʌ":"V","Ꝡ":"VY","Ⓦ":"W","Ｗ":"W","Ẁ":"W","Ẃ":"W","Ŵ":"W","Ẇ":"W","Ẅ":"W","Ẉ":"W","Ⱳ":"W","Ⓧ":"X","Ｘ":"X","Ẋ":"X","Ẍ":"X","Ⓨ":"Y","Ｙ":"Y","Ỳ":"Y","Ý":"Y","Ŷ":"Y","Ỹ":"Y","Ȳ":"Y","Ẏ":"Y","Ÿ":"Y","Ỷ":"Y","Ỵ":"Y","Ƴ":"Y","Ɏ":"Y","Ỿ":"Y","Ⓩ":"Z","Ｚ":"Z","Ź":"Z","Ẑ":"Z","Ż":"Z","Ž":"Z","Ẓ":"Z","Ẕ":"Z","Ƶ":"Z","Ȥ":"Z","Ɀ":"Z","Ⱬ":"Z","Ꝣ":"Z","ⓐ":"a","ａ":"a","ẚ":"a","à":"a","á":"a","â":"a","ầ":"a","ấ":"a","ẫ":"a","ẩ":"a","ã":"a","ā":"a","ă":"a","ằ":"a","ắ":"a","ẵ":"a","ẳ":"a","ȧ":"a","ǡ":"a","ä":"a","ǟ":"a","ả":"a","å":"a","ǻ":"a","ǎ":"a","ȁ":"a","ȃ":"a","ạ":"a","ậ":"a","ặ":"a","ḁ":"a","ą":"a","ⱥ":"a","ɐ":"a","ꜳ":"aa","æ":"ae","ǽ":"ae","ǣ":"ae","ꜵ":"ao","ꜷ":"au","ꜹ":"av","ꜻ":"av","ꜽ":"ay","ⓑ":"b","ｂ":"b","ḃ":"b","ḅ":"b","ḇ":"b","ƀ":"b","ƃ":"b","ɓ":"b","ⓒ":"c","ｃ":"c","ć":"c","ĉ":"c","ċ":"c","č":"c","ç":"c","ḉ":"c","ƈ":"c","ȼ":"c","ꜿ":"c","ↄ":"c","ⓓ":"d","ｄ":"d","ḋ":"d","ď":"d","ḍ":"d","ḑ":"d","ḓ":"d","ḏ":"d","đ":"d","ƌ":"d","ɖ":"d","ɗ":"d","ꝺ":"d","ǳ":"dz","ǆ":"dz","ⓔ":"e","ｅ":"e","è":"e","é":"e","ê":"e","ề":"e","ế":"e","ễ":"e","ể":"e","ẽ":"e","ē":"e","ḕ":"e","ḗ":"e","ĕ":"e","ė":"e","ë":"e","ẻ":"e","ě":"e","ȅ":"e","ȇ":"e","ẹ":"e","ệ":"e","ȩ":"e","ḝ":"e","ę":"e","ḙ":"e","ḛ":"e","ɇ":"e","ɛ":"e","ǝ":"e","ⓕ":"f","ｆ":"f","ḟ":"f","ƒ":"f","ꝼ":"f","ⓖ":"g","ｇ":"g","ǵ":"g","ĝ":"g","ḡ":"g","ğ":"g","ġ":"g","ǧ":"g","ģ":"g","ǥ":"g","ɠ":"g","ꞡ":"g","ᵹ":"g","ꝿ":"g","ⓗ":"h","ｈ":"h","ĥ":"h","ḣ":"h","ḧ":"h","ȟ":"h","ḥ":"h","ḩ":"h","ḫ":"h","ẖ":"h","ħ":"h","ⱨ":"h","ⱶ":"h","ɥ":"h","ƕ":"hv","ⓘ":"i","ｉ":"i","ì":"i","í":"i","î":"i","ĩ":"i","ī":"i","ĭ":"i","ï":"i","ḯ":"i","ỉ":"i","ǐ":"i","ȉ":"i","ȋ":"i","ị":"i","į":"i","ḭ":"i","ɨ":"i","ı":"i","ⓙ":"j","ｊ":"j","ĵ":"j","ǰ":"j","ɉ":"j","ⓚ":"k","ｋ":"k","ḱ":"k","ǩ":"k","ḳ":"k","ķ":"k","ḵ":"k","ƙ":"k","ⱪ":"k","ꝁ":"k","ꝃ":"k","ꝅ":"k","ꞣ":"k","ⓛ":"l","ｌ":"l","ŀ":"l","ĺ":"l","ľ":"l","ḷ":"l","ḹ":"l","ļ":"l","ḽ":"l","ḻ":"l","ſ":"l","ł":"l","ƚ":"l","ɫ":"l","ⱡ":"l","ꝉ":"l","ꞁ":"l","ꝇ":"l","ǉ":"lj","ⓜ":"m","ｍ":"m","ḿ":"m","ṁ":"m","ṃ":"m","ɱ":"m","ɯ":"m","ⓝ":"n","ｎ":"n","ǹ":"n","ń":"n","ñ":"n","ṅ":"n","ň":"n","ṇ":"n","ņ":"n","ṋ":"n","ṉ":"n","ƞ":"n","ɲ":"n","ŉ":"n","ꞑ":"n","ꞥ":"n","ǌ":"nj","ⓞ":"o","ｏ":"o","ò":"o","ó":"o","ô":"o","ồ":"o","ố":"o","ỗ":"o","ổ":"o","õ":"o","ṍ":"o","ȭ":"o","ṏ":"o","ō":"o","ṑ":"o","ṓ":"o","ŏ":"o","ȯ":"o","ȱ":"o","ö":"o","ȫ":"o","ỏ":"o","ő":"o","ǒ":"o","ȍ":"o","ȏ":"o","ơ":"o","ờ":"o","ớ":"o","ỡ":"o","ở":"o","ợ":"o","ọ":"o","ộ":"o","ǫ":"o","ǭ":"o","ø":"o","ǿ":"o","ɔ":"o","ꝋ":"o","ꝍ":"o","ɵ":"o","ƣ":"oi","ȣ":"ou","ꝏ":"oo","ⓟ":"p","ｐ":"p","ṕ":"p","ṗ":"p","ƥ":"p","ᵽ":"p","ꝑ":"p","ꝓ":"p","ꝕ":"p","ⓠ":"q","ｑ":"q","ɋ":"q","ꝗ":"q","ꝙ":"q","ⓡ":"r","ｒ":"r","ŕ":"r","ṙ":"r","ř":"r","ȑ":"r","ȓ":"r","ṛ":"r","ṝ":"r","ŗ":"r","ṟ":"r","ɍ":"r","ɽ":"r","ꝛ":"r","ꞧ":"r","ꞃ":"r","ⓢ":"s","ｓ":"s","ß":"s","ś":"s","ṥ":"s","ŝ":"s","ṡ":"s","š":"s","ṧ":"s","ṣ":"s","ṩ":"s","ș":"s","ş":"s","ȿ":"s","ꞩ":"s","ꞅ":"s","ẛ":"s","ⓣ":"t","ｔ":"t","ṫ":"t","ẗ":"t","ť":"t","ṭ":"t","ț":"t","ţ":"t","ṱ":"t","ṯ":"t","ŧ":"t","ƭ":"t","ʈ":"t","ⱦ":"t","ꞇ":"t","ꜩ":"tz","ⓤ":"u","ｕ":"u","ù":"u","ú":"u","û":"u","ũ":"u","ṹ":"u","ū":"u","ṻ":"u","ŭ":"u","ü":"u","ǜ":"u","ǘ":"u","ǖ":"u","ǚ":"u","ủ":"u","ů":"u","ű":"u","ǔ":"u","ȕ":"u","ȗ":"u","ư":"u","ừ":"u","ứ":"u","ữ":"u","ử":"u","ự":"u","ụ":"u","ṳ":"u","ų":"u","ṷ":"u","ṵ":"u","ʉ":"u","ⓥ":"v","ｖ":"v","ṽ":"v","ṿ":"v","ʋ":"v","ꝟ":"v","ʌ":"v","ꝡ":"vy","ⓦ":"w","ｗ":"w","ẁ":"w","ẃ":"w","ŵ":"w","ẇ":"w","ẅ":"w","ẘ":"w","ẉ":"w","ⱳ":"w","ⓧ":"x","ｘ":"x","ẋ":"x","ẍ":"x","ⓨ":"y","ｙ":"y","ỳ":"y","ý":"y","ŷ":"y","ỹ":"y","ȳ":"y","ẏ":"y","ÿ":"y","ỷ":"y","ẙ":"y","ỵ":"y","ƴ":"y","ɏ":"y","ỿ":"y","ⓩ":"z","ｚ":"z","ź":"z","ẑ":"z","ż":"z","ž":"z","ẓ":"z","ẕ":"z","ƶ":"z","ȥ":"z","ɀ":"z","ⱬ":"z","ꝣ":"z","Ά":"Α","Έ":"Ε","Ή":"Η","Ί":"Ι","Ϊ":"Ι","Ό":"Ο","Ύ":"Υ","Ϋ":"Υ","Ώ":"Ω","ά":"α","έ":"ε","ή":"η","ί":"ι","ϊ":"ι","ΐ":"ι","ό":"ο","ύ":"υ","ϋ":"υ","ΰ":"υ","ω":"ω","ς":"σ"}}),b.define("select2/data/base",["../utils"],function(a){function b(a,c){b.__super__.constructor.call(this)}return a.Extend(b,a.Observable),b.prototype.current=function(a){throw new Error("The `current` method must be defined in child classes.")},b.prototype.query=function(a,b){throw new Error("The `query` method must be defined in child classes.")},b.prototype.bind=function(a,b){},b.prototype.destroy=function(){},b.prototype.generateResultId=function(b,c){var d=b.id+"-result-";return d+=a.generateChars(4),null!=c.id?d+="-"+c.id.toString():d+="-"+a.generateChars(4),d},b}),b.define("select2/data/select",["./base","../utils","jquery"],function(a,b,c){function d(a,b){this.$element=a,this.options=b,d.__super__.constructor.call(this)}return b.Extend(d,a),d.prototype.current=function(a){var b=[],d=this;this.$element.find(":selected").each(function(){var a=c(this),e=d.item(a);b.push(e)}),a(b)},d.prototype.select=function(a){var b=this;if(a.selected=!0,c(a.element).is("option"))return a.element.selected=!0,void this.$element.trigger("change");if(this.$element.prop("multiple"))this.current(function(d){var e=[];a=[a],a.push.apply(a,d);for(var f=0;f<a.length;f++){var g=a[f].id;-1===c.inArray(g,e)&&e.push(g)}b.$element.val(e),b.$element.trigger("change")});else{var d=a.id;this.$element.val(d),this.$element.trigger("change")}},d.prototype.unselect=function(a){var b=this;if(this.$element.prop("multiple")){if(a.selected=!1,c(a.element).is("option"))return a.element.selected=!1,void this.$element.trigger("change");this.current(function(d){for(var e=[],f=0;f<d.length;f++){var g=d[f].id;g!==a.id&&-1===c.inArray(g,e)&&e.push(g)}b.$element.val(e),b.$element.trigger("change")})}},d.prototype.bind=function(a,b){var c=this;this.container=a,a.on("select",function(a){c.select(a.data)}),a.on("unselect",function(a){c.unselect(a.data)})},d.prototype.destroy=function(){this.$element.find("*").each(function(){b.RemoveData(this)})},d.prototype.query=function(a,b){var d=[],e=this;this.$element.children().each(function(){var b=c(this);if(b.is("option")||b.is("optgroup")){var f=e.item(b),g=e.matches(a,f);null!==g&&d.push(g)}}),b({results:d})},d.prototype.addOptions=function(a){b.appendMany(this.$element,a)},d.prototype.option=function(a){var d;a.children?(d=document.createElement("optgroup"),d.label=a.text):(d=document.createElement("option"),void 0!==d.textContent?d.textContent=a.text:d.innerText=a.text),void 0!==a.id&&(d.value=a.id),a.disabled&&(d.disabled=!0),a.selected&&(d.selected=!0),a.title&&(d.title=a.title);var e=c(d),f=this._normalizeItem(a);return f.element=d,b.StoreData(d,"data",f),e},d.prototype.item=function(a){var d={};if(null!=(d=b.GetData(a[0],"data")))return d;if(a.is("option"))d={id:a.val(),text:a.text(),disabled:a.prop("disabled"),selected:a.prop("selected"),title:a.prop("title")};else if(a.is("optgroup")){d={text:a.prop("label"),children:[],title:a.prop("title")};for(var e=a.children("option"),f=[],g=0;g<e.length;g++){var h=c(e[g]),i=this.item(h);f.push(i)}d.children=f}return d=this._normalizeItem(d),d.element=a[0],b.StoreData(a[0],"data",d),d},d.prototype._normalizeItem=function(a){a!==Object(a)&&(a={id:a,text:a}),a=c.extend({},{text:""},a);var b={selected:!1,disabled:!1};return null!=a.id&&(a.id=a.id.toString()),null!=a.text&&(a.text=a.text.toString()),null==a._resultId&&a.id&&null!=this.container&&(a._resultId=this.generateResultId(this.container,a)),c.extend({},b,a)},d.prototype.matches=function(a,b){return this.options.get("matcher")(a,b)},d}),b.define("select2/data/array",["./select","../utils","jquery"],function(a,b,c){function d(a,b){var c=b.get("data")||[];d.__super__.constructor.call(this,a,b),this.addOptions(this.convertToOptions(c))}return b.Extend(d,a),d.prototype.select=function(a){var b=this.$element.find("option").filter(function(b,c){return c.value==a.id.toString()});0===b.length&&(b=this.option(a),this.addOptions(b)),d.__super__.select.call(this,a)},d.prototype.convertToOptions=function(a){function d(a){return function(){return c(this).val()==a.id}}for(var e=this,f=this.$element.find("option"),g=f.map(function(){return e.item(c(this)).id}).get(),h=[],i=0;i<a.length;i++){var j=this._normalizeItem(a[i]);if(c.inArray(j.id,g)>=0){var k=f.filter(d(j)),l=this.item(k),m=c.extend(!0,{},j,l),n=this.option(m);k.replaceWith(n)}else{var o=this.option(j);if(j.children){var p=this.convertToOptions(j.children);b.appendMany(o,p)}h.push(o)}}return h},d}),b.define("select2/data/ajax",["./array","../utils","jquery"],function(a,b,c){function d(a,b){this.ajaxOptions=this._applyDefaults(b.get("ajax")),null!=this.ajaxOptions.processResults&&(this.processResults=this.ajaxOptions.processResults),d.__super__.constructor.call(this,a,b)}return b.Extend(d,a),d.prototype._applyDefaults=function(a){var b={data:function(a){return c.extend({},a,{q:a.term})},transport:function(a,b,d){var e=c.ajax(a);return e.then(b),e.fail(d),e}};return c.extend({},b,a,!0)},d.prototype.processResults=function(a){return a},d.prototype.query=function(a,b){function d(){var d=f.transport(f,function(d){var f=e.processResults(d,a);e.options.get("debug")&&window.console&&console.error&&(f&&f.results&&c.isArray(f.results)||console.error("Select2: The AJAX results did not return an array in the `results` key of the response.")),b(f)},function(){"status"in d&&(0===d.status||"0"===d.status)||e.trigger("results:message",{message:"errorLoading"})});e._request=d}var e=this;null!=this._request&&(c.isFunction(this._request.abort)&&this._request.abort(),this._request=null);var f=c.extend({type:"GET"},this.ajaxOptions);"function"==typeof f.url&&(f.url=f.url.call(this.$element,a)),"function"==typeof f.data&&(f.data=f.data.call(this.$element,a)),this.ajaxOptions.delay&&null!=a.term?(this._queryTimeout&&window.clearTimeout(this._queryTimeout),this._queryTimeout=window.setTimeout(d,this.ajaxOptions.delay)):d()},d}),b.define("select2/data/tags",["jquery"],function(a){function b(b,c,d){var e=d.get("tags"),f=d.get("createTag");void 0!==f&&(this.createTag=f);var g=d.get("insertTag");if(void 0!==g&&(this.insertTag=g),b.call(this,c,d),a.isArray(e))for(var h=0;h<e.length;h++){var i=e[h],j=this._normalizeItem(i),k=this.option(j);this.$element.append(k)}}return b.prototype.query=function(a,b,c){function d(a,f){for(var g=a.results,h=0;h<g.length;h++){var i=g[h],j=null!=i.children&&!d({results:i.children},!0);if((i.text||"").toUpperCase()===(b.term||"").toUpperCase()||j)return!f&&(a.data=g,void c(a))}if(f)return!0;var k=e.createTag(b);if(null!=k){var l=e.option(k);l.attr("data-select2-tag",!0),e.addOptions([l]),e.insertTag(g,k)}a.results=g,c(a)}var e=this;if(this._removeOldTags(),null==b.term||null!=b.page)return void a.call(this,b,c);a.call(this,b,d)},b.prototype.createTag=function(b,c){var d=a.trim(c.term);return""===d?null:{id:d,text:d}},b.prototype.insertTag=function(a,b,c){b.unshift(c)},b.prototype._removeOldTags=function(b){this._lastTag;this.$element.find("option[data-select2-tag]").each(function(){this.selected||a(this).remove()})},b}),b.define("select2/data/tokenizer",["jquery"],function(a){function b(a,b,c){var d=c.get("tokenizer");void 0!==d&&(this.tokenizer=d),a.call(this,b,c)}return b.prototype.bind=function(a,b,c){a.call(this,b,c),this.$search=b.dropdown.$search||b.selection.$search||c.find(".select2-search__field")},b.prototype.query=function(b,c,d){function e(b){var c=g._normalizeItem(b);if(!g.$element.find("option").filter(function(){return a(this).val()===c.id}).length){var d=g.option(c);d.attr("data-select2-tag",!0),g._removeOldTags(),g.addOptions([d])}f(c)}function f(a){g.trigger("select",{data:a})}var g=this;c.term=c.term||"";var h=this.tokenizer(c,this.options,e);h.term!==c.term&&(this.$search.length&&(this.$search.val(h.term),this.$search.focus()),c.term=h.term),b.call(this,c,d)},b.prototype.tokenizer=function(b,c,d,e){for(var f=d.get("tokenSeparators")||[],g=c.term,h=0,i=this.createTag||function(a){return{id:a.term,text:a.term}};h<g.length;){var j=g[h];if(-1!==a.inArray(j,f)){var k=g.substr(0,h),l=a.extend({},c,{term:k}),m=i(l);null!=m?(e(m),g=g.substr(h+1)||"",h=0):h++}else h++}return{term:g}},b}),b.define("select2/data/minimumInputLength",[],function(){function a(a,b,c){this.minimumInputLength=c.get("minimumInputLength"),a.call(this,b,c)}return a.prototype.query=function(a,b,c){if(b.term=b.term||"",b.term.length<this.minimumInputLength)return void this.trigger("results:message",{message:"inputTooShort",args:{minimum:this.minimumInputLength,input:b.term,params:b}});a.call(this,b,c)},a}),b.define("select2/data/maximumInputLength",[],function(){function a(a,b,c){this.maximumInputLength=c.get("maximumInputLength"),a.call(this,b,c)}return a.prototype.query=function(a,b,c){if(b.term=b.term||"",this.maximumInputLength>0&&b.term.length>this.maximumInputLength)return void this.trigger("results:message",{message:"inputTooLong",args:{maximum:this.maximumInputLength,input:b.term,params:b}});a.call(this,b,c)},a}),b.define("select2/data/maximumSelectionLength",[],function(){function a(a,b,c){this.maximumSelectionLength=c.get("maximumSelectionLength"),a.call(this,b,c)}return a.prototype.query=function(a,b,c){var d=this;this.current(function(e){var f=null!=e?e.length:0;if(d.maximumSelectionLength>0&&f>=d.maximumSelectionLength)return void d.trigger("results:message",{message:"maximumSelected",args:{maximum:d.maximumSelectionLength}});a.call(d,b,c)})},a}),b.define("select2/dropdown",["jquery","./utils"],function(a,b){function c(a,b){this.$element=a,this.options=b,c.__super__.constructor.call(this)}return b.Extend(c,b.Observable),c.prototype.render=function(){var b=a('<span class="select2-dropdown"><span class="select2-results"></span></span>');return b.attr("dir",this.options.get("dir")),this.$dropdown=b,b},c.prototype.bind=function(){},c.prototype.position=function(a,b){},c.prototype.destroy=function(){this.$dropdown.remove()},c}),b.define("select2/dropdown/search",["jquery","../utils"],function(a,b){function c(){}return c.prototype.render=function(b){var c=b.call(this),d=a('<span class="select2-search select2-search--dropdown"><input class="select2-search__field" type="search" tabindex="-1" autocomplete="off" autocorrect="off" autocapitalize="none" spellcheck="false" role="textbox" /></span>');return this.$searchContainer=d,this.$search=d.find("input"),c.prepend(d),c},c.prototype.bind=function(b,c,d){var e=this;b.call(this,c,d),this.$search.on("keydown",function(a){e.trigger("keypress",a),e._keyUpPrevented=a.isDefaultPrevented()}),this.$search.on("input",function(b){a(this).off("keyup")}),this.$search.on("keyup input",function(a){e.handleSearch(a)}),c.on("open",function(){e.$search.attr("tabindex",0),e.$search.focus(),window.setTimeout(function(){e.$search.focus()},0)}),c.on("close",function(){e.$search.attr("tabindex",-1),e.$search.val(""),e.$search.blur()}),c.on("focus",function(){c.isOpen()||e.$search.focus()}),c.on("results:all",function(a){if(null==a.query.term||""===a.query.term){e.showSearch(a)?e.$searchContainer.removeClass("select2-search--hide"):e.$searchContainer.addClass("select2-search--hide")}})},c.prototype.handleSearch=function(a){if(!this._keyUpPrevented){var b=this.$search.val();this.trigger("query",{term:b})}this._keyUpPrevented=!1},c.prototype.showSearch=function(a,b){return!0},c}),b.define("select2/dropdown/hidePlaceholder",[],function(){function a(a,b,c,d){this.placeholder=this.normalizePlaceholder(c.get("placeholder")),a.call(this,b,c,d)}return a.prototype.append=function(a,b){b.results=this.removePlaceholder(b.results),a.call(this,b)},a.prototype.normalizePlaceholder=function(a,b){return"string"==typeof b&&(b={id:"",text:b}),b},a.prototype.removePlaceholder=function(a,b){for(var c=b.slice(0),d=b.length-1;d>=0;d--){var e=b[d];this.placeholder.id===e.id&&c.splice(d,1)}return c},a}),b.define("select2/dropdown/infiniteScroll",["jquery"],function(a){function b(a,b,c,d){this.lastParams={},a.call(this,b,c,d),this.$loadingMore=this.createLoadingMore(),this.loading=!1}return b.prototype.append=function(a,b){this.$loadingMore.remove(),this.loading=!1,a.call(this,b),this.showLoadingMore(b)&&this.$results.append(this.$loadingMore)},b.prototype.bind=function(b,c,d){var e=this;b.call(this,c,d),c.on("query",function(a){e.lastParams=a,e.loading=!0}),c.on("query:append",function(a){e.lastParams=a,e.loading=!0}),this.$results.on("scroll",function(){var b=a.contains(document.documentElement,e.$loadingMore[0]);if(!e.loading&&b){e.$results.offset().top+e.$results.outerHeight(!1)+50>=e.$loadingMore.offset().top+e.$loadingMore.outerHeight(!1)&&e.loadMore()}})},b.prototype.loadMore=function(){this.loading=!0;var b=a.extend({},{page:1},this.lastParams);b.page++,this.trigger("query:append",b)},b.prototype.showLoadingMore=function(a,b){return b.pagination&&b.pagination.more},b.prototype.createLoadingMore=function(){var b=a('<li class="select2-results__option select2-results__option--load-more"role="treeitem" aria-disabled="true"></li>'),c=this.options.get("translations").get("loadingMore");return b.html(c(this.lastParams)),b},b}),b.define("select2/dropdown/attachBody",["jquery","../utils"],function(a,b){function c(b,c,d){this.$dropdownParent=d.get("dropdownParent")||a(document.body),b.call(this,c,d)}return c.prototype.bind=function(a,b,c){var d=this,e=!1;a.call(this,b,c),b.on("open",function(){d._showDropdown(),d._attachPositioningHandler(b),e||(e=!0,b.on("results:all",function(){d._positionDropdown(),d._resizeDropdown()}),b.on("results:append",function(){d._positionDropdown(),d._resizeDropdown()}))}),b.on("close",function(){d._hideDropdown(),d._detachPositioningHandler(b)}),this.$dropdownContainer.on("mousedown",function(a){a.stopPropagation()})},c.prototype.destroy=function(a){a.call(this),this.$dropdownContainer.remove()},c.prototype.position=function(a,b,c){b.attr("class",c.attr("class")),b.removeClass("select2"),b.addClass("select2-container--open"),b.css({position:"absolute",top:-999999}),this.$container=c},c.prototype.render=function(b){var c=a("<span></span>"),d=b.call(this);return c.append(d),this.$dropdownContainer=c,c},c.prototype._hideDropdown=function(a){this.$dropdownContainer.detach()},c.prototype._attachPositioningHandler=function(c,d){var e=this,f="scroll.select2."+d.id,g="resize.select2."+d.id,h="orientationchange.select2."+d.id,i=this.$container.parents().filter(b.hasScroll);i.each(function(){b.StoreData(this,"select2-scroll-position",{x:a(this).scrollLeft(),y:a(this).scrollTop()})}),i.on(f,function(c){var d=b.GetData(this,"select2-scroll-position");a(this).scrollTop(d.y)}),a(window).on(f+" "+g+" "+h,function(a){e._positionDropdown(),e._resizeDropdown()})},c.prototype._detachPositioningHandler=function(c,d){var e="scroll.select2."+d.id,f="resize.select2."+d.id,g="orientationchange.select2."+d.id;this.$container.parents().filter(b.hasScroll).off(e),a(window).off(e+" "+f+" "+g)},c.prototype._positionDropdown=function(){var b=a(window),c=this.$dropdown.hasClass("select2-dropdown--above"),d=this.$dropdown.hasClass("select2-dropdown--below"),e=null,f=this.$container.offset();f.bottom=f.top+this.$container.outerHeight(!1);var g={height:this.$container.outerHeight(!1)};g.top=f.top,g.bottom=f.top+g.height;var h={height:this.$dropdown.outerHeight(!1)},i={top:b.scrollTop(),bottom:b.scrollTop()+b.height()},j=i.top<f.top-h.height,k=i.bottom>f.bottom+h.height,l={left:f.left,top:g.bottom},m=this.$dropdownParent;"static"===m.css("position")&&(m=m.offsetParent());var n=m.offset();l.top-=n.top,l.left-=n.left,c||d||(e="below"),k||!j||c?!j&&k&&c&&(e="below"):e="above",("above"==e||c&&"below"!==e)&&(l.top=g.top-n.top-h.height),null!=e&&(this.$dropdown.removeClass("select2-dropdown--below select2-dropdown--above").addClass("select2-dropdown--"+e),this.$container.removeClass("select2-container--below select2-container--above").addClass("select2-container--"+e)),this.$dropdownContainer.css(l)},c.prototype._resizeDropdown=function(){var a={width:this.$container.outerWidth(!1)+"px"};this.options.get("dropdownAutoWidth")&&(a.minWidth=a.width,a.position="relative",a.width="auto"),this.$dropdown.css(a)},c.prototype._showDropdown=function(a){this.$dropdownContainer.appendTo(this.$dropdownParent),this._positionDropdown(),this._resizeDropdown()},c}),b.define("select2/dropdown/minimumResultsForSearch",[],function(){function a(b){for(var c=0,d=0;d<b.length;d++){var e=b[d];e.children?c+=a(e.children):c++}return c}function b(a,b,c,d){this.minimumResultsForSearch=c.get("minimumResultsForSearch"),this.minimumResultsForSearch<0&&(this.minimumResultsForSearch=1/0),a.call(this,b,c,d)}return b.prototype.showSearch=function(b,c){return!(a(c.data.results)<this.minimumResultsForSearch)&&b.call(this,c)},b}),b.define("select2/dropdown/selectOnClose",["../utils"],function(a){function b(){}return b.prototype.bind=function(a,b,c){var d=this;a.call(this,b,c),b.on("close",function(a){d._handleSelectOnClose(a)})},b.prototype._handleSelectOnClose=function(b,c){if(c&&null!=c.originalSelect2Event){var d=c.originalSelect2Event;if("select"===d._type||"unselect"===d._type)return}var e=this.getHighlightedResults();if(!(e.length<1)){var f=a.GetData(e[0],"data");null!=f.element&&f.element.selected||null==f.element&&f.selected||this.trigger("select",{data:f})}},b}),b.define("select2/dropdown/closeOnSelect",[],function(){function a(){}return a.prototype.bind=function(a,b,c){var d=this;a.call(this,b,c),b.on("select",function(a){d._selectTriggered(a)}),b.on("unselect",function(a){d._selectTriggered(a)})},a.prototype._selectTriggered=function(a,b){var c=b.originalEvent;c&&c.ctrlKey||this.trigger("close",{originalEvent:c,originalSelect2Event:b})},a}),b.define("select2/i18n/en",[],function(){return{errorLoading:function(){return"The results could not be loaded."},inputTooLong:function(a){var b=a.input.length-a.maximum,c="Please delete "+b+" character";return 1!=b&&(c+="s"),c},inputTooShort:function(a){return"Please enter "+(a.minimum-a.input.length)+" or more characters"},loadingMore:function(){return"Loading more results…"},maximumSelected:function(a){var b="You can only select "+a.maximum+" item";return 1!=a.maximum&&(b+="s"),b},noResults:function(){return"No results found"},searching:function(){return"Searching…"}}}),b.define("select2/defaults",["jquery","require","./results","./selection/single","./selection/multiple","./selection/placeholder","./selection/allowClear","./selection/search","./selection/eventRelay","./utils","./translation","./diacritics","./data/select","./data/array","./data/ajax","./data/tags","./data/tokenizer","./data/minimumInputLength","./data/maximumInputLength","./data/maximumSelectionLength","./dropdown","./dropdown/search","./dropdown/hidePlaceholder","./dropdown/infiniteScroll","./dropdown/attachBody","./dropdown/minimumResultsForSearch","./dropdown/selectOnClose","./dropdown/closeOnSelect","./i18n/en"],function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C){function D(){this.reset()}return D.prototype.apply=function(l){if(l=a.extend(!0,{},this.defaults,l),null==l.dataAdapter){if(null!=l.ajax?l.dataAdapter=o:null!=l.data?l.dataAdapter=n:l.dataAdapter=m,l.minimumInputLength>0&&(l.dataAdapter=j.Decorate(l.dataAdapter,r)),l.maximumInputLength>0&&(l.dataAdapter=j.Decorate(l.dataAdapter,s)),l.maximumSelectionLength>0&&(l.dataAdapter=j.Decorate(l.dataAdapter,t)),l.tags&&(l.dataAdapter=j.Decorate(l.dataAdapter,p)),null==l.tokenSeparators&&null==l.tokenizer||(l.dataAdapter=j.Decorate(l.dataAdapter,q)),null!=l.query){var C=b(l.amdBase+"compat/query");l.dataAdapter=j.Decorate(l.dataAdapter,C)}if(null!=l.initSelection){var D=b(l.amdBase+"compat/initSelection");l.dataAdapter=j.Decorate(l.dataAdapter,D)}}if(null==l.resultsAdapter&&(l.resultsAdapter=c,null!=l.ajax&&(l.resultsAdapter=j.Decorate(l.resultsAdapter,x)),null!=l.placeholder&&(l.resultsAdapter=j.Decorate(l.resultsAdapter,w)),l.selectOnClose&&(l.resultsAdapter=j.Decorate(l.resultsAdapter,A))),null==l.dropdownAdapter){if(l.multiple)l.dropdownAdapter=u;else{var E=j.Decorate(u,v);l.dropdownAdapter=E}if(0!==l.minimumResultsForSearch&&(l.dropdownAdapter=j.Decorate(l.dropdownAdapter,z)),l.closeOnSelect&&(l.dropdownAdapter=j.Decorate(l.dropdownAdapter,B)),null!=l.dropdownCssClass||null!=l.dropdownCss||null!=l.adaptDropdownCssClass){var F=b(l.amdBase+"compat/dropdownCss");l.dropdownAdapter=j.Decorate(l.dropdownAdapter,F)}l.dropdownAdapter=j.Decorate(l.dropdownAdapter,y)}if(null==l.selectionAdapter){if(l.multiple?l.selectionAdapter=e:l.selectionAdapter=d,null!=l.placeholder&&(l.selectionAdapter=j.Decorate(l.selectionAdapter,f)),l.allowClear&&(l.selectionAdapter=j.Decorate(l.selectionAdapter,g)),l.multiple&&(l.selectionAdapter=j.Decorate(l.selectionAdapter,h)),null!=l.containerCssClass||null!=l.containerCss||null!=l.adaptContainerCssClass){var G=b(l.amdBase+"compat/containerCss");l.selectionAdapter=j.Decorate(l.selectionAdapter,G)}l.selectionAdapter=j.Decorate(l.selectionAdapter,i)}if("string"==typeof l.language)if(l.language.indexOf("-")>0){var H=l.language.split("-"),I=H[0];l.language=[l.language,I]}else l.language=[l.language];if(a.isArray(l.language)){var J=new k;l.language.push("en");for(var K=l.language,L=0;L<K.length;L++){var M=K[L],N={};try{N=k.loadPath(M)}catch(a){try{M=this.defaults.amdLanguageBase+M,N=k.loadPath(M)}catch(a){l.debug&&window.console&&console.warn&&console.warn('Select2: The language file for "'+M+'" could not be automatically loaded. A fallback will be used instead.');continue}}J.extend(N)}l.translations=J}else{var O=k.loadPath(this.defaults.amdLanguageBase+"en"),P=new k(l.language);P.extend(O),l.translations=P}return l},D.prototype.reset=function(){function b(a){function b(a){return l[a]||a}return a.replace(/[^\u0000-\u007E]/g,b)}function c(d,e){if(""===a.trim(d.term))return e;if(e.children&&e.children.length>0){for(var f=a.extend(!0,{},e),g=e.children.length-1;g>=0;g--){null==c(d,e.children[g])&&f.children.splice(g,1)}return f.children.length>0?f:c(d,f)}var h=b(e.text).toUpperCase(),i=b(d.term).toUpperCase();return h.indexOf(i)>-1?e:null}this.defaults={amdBase:"./",amdLanguageBase:"./i18n/",closeOnSelect:!0,debug:!1,dropdownAutoWidth:!1,escapeMarkup:j.escapeMarkup,language:C,matcher:c,minimumInputLength:0,maximumInputLength:0,maximumSelectionLength:0,minimumResultsForSearch:0,selectOnClose:!1,sorter:function(a){return a},templateResult:function(a){return a.text},templateSelection:function(a){return a.text},theme:"default",width:"resolve"}},D.prototype.set=function(b,c){var d=a.camelCase(b),e={};e[d]=c;var f=j._convertData(e);a.extend(!0,this.defaults,f)},new D}),b.define("select2/options",["require","jquery","./defaults","./utils"],function(a,b,c,d){function e(b,e){if(this.options=b,null!=e&&this.fromElement(e),this.options=c.apply(this.options),e&&e.is("input")){var f=a(this.get("amdBase")+"compat/inputData");this.options.dataAdapter=d.Decorate(this.options.dataAdapter,f)}}return e.prototype.fromElement=function(a){var c=["select2"];null==this.options.multiple&&(this.options.multiple=a.prop("multiple")),null==this.options.disabled&&(this.options.disabled=a.prop("disabled")),null==this.options.language&&(a.prop("lang")?this.options.language=a.prop("lang").toLowerCase():a.closest("[lang]").prop("lang")&&(this.options.language=a.closest("[lang]").prop("lang"))),null==this.options.dir&&(a.prop("dir")?this.options.dir=a.prop("dir"):a.closest("[dir]").prop("dir")?this.options.dir=a.closest("[dir]").prop("dir"):this.options.dir="ltr"),a.prop("disabled",this.options.disabled),a.prop("multiple",this.options.multiple),d.GetData(a[0],"select2Tags")&&(this.options.debug&&window.console&&console.warn&&console.warn('Select2: The `data-select2-tags` attribute has been changed to use the `data-data` and `data-tags="true"` attributes and will be removed in future versions of Select2.'),d.StoreData(a[0],"data",d.GetData(a[0],"select2Tags")),d.StoreData(a[0],"tags",!0)),d.GetData(a[0],"ajaxUrl")&&(this.options.debug&&window.console&&console.warn&&console.warn("Select2: The `data-ajax-url` attribute has been changed to `data-ajax--url` and support for the old attribute will be removed in future versions of Select2."),a.attr("ajax--url",d.GetData(a[0],"ajaxUrl")),d.StoreData(a[0],"ajax-Url",d.GetData(a[0],"ajaxUrl")));var e={};e=b.fn.jquery&&"1."==b.fn.jquery.substr(0,2)&&a[0].dataset?b.extend(!0,{},a[0].dataset,d.GetData(a[0])):d.GetData(a[0]);var f=b.extend(!0,{},e);f=d._convertData(f);for(var g in f)b.inArray(g,c)>-1||(b.isPlainObject(this.options[g])?b.extend(this.options[g],f[g]):this.options[g]=f[g]);return this},e.prototype.get=function(a){return this.options[a]},e.prototype.set=function(a,b){this.options[a]=b},e}),b.define("select2/core",["jquery","./options","./utils","./keys"],function(a,b,c,d){var e=function(a,d){null!=c.GetData(a[0],"select2")&&c.GetData(a[0],"select2").destroy(),this.$element=a,this.id=this._generateId(a),d=d||{},this.options=new b(d,a),e.__super__.constructor.call(this);var f=a.attr("tabindex")||0;c.StoreData(a[0],"old-tabindex",f),a.attr("tabindex","-1");var g=this.options.get("dataAdapter");this.dataAdapter=new g(a,this.options);var h=this.render();this._placeContainer(h);var i=this.options.get("selectionAdapter");this.selection=new i(a,this.options),this.$selection=this.selection.render(),this.selection.position(this.$selection,h);var j=this.options.get("dropdownAdapter");this.dropdown=new j(a,this.options),this.$dropdown=this.dropdown.render(),this.dropdown.position(this.$dropdown,h);var k=this.options.get("resultsAdapter");this.results=new k(a,this.options,this.dataAdapter),this.$results=this.results.render(),this.results.position(this.$results,this.$dropdown);var l=this;this._bindAdapters(),this._registerDomEvents(),this._registerDataEvents(),this._registerSelectionEvents(),this._registerDropdownEvents(),this._registerResultsEvents(),this._registerEvents(),this.dataAdapter.current(function(a){l.trigger("selection:update",{data:a})}),a.addClass("select2-hidden-accessible"),a.attr("aria-hidden","true"),this._syncAttributes(),c.StoreData(a[0],"select2",this),a.data("select2",this)};return c.Extend(e,c.Observable),e.prototype._generateId=function(a){var b="";return b=null!=a.attr("id")?a.attr("id"):null!=a.attr("name")?a.attr("name")+"-"+c.generateChars(2):c.generateChars(4),b=b.replace(/(:|\.|\[|\]|,)/g,""),b="select2-"+b},e.prototype._placeContainer=function(a){a.insertAfter(this.$element);var b=this._resolveWidth(this.$element,this.options.get("width"));null!=b&&a.css("width",b)},e.prototype._resolveWidth=function(a,b){var c=/^width:(([-+]?([0-9]*\.)?[0-9]+)(px|em|ex|%|in|cm|mm|pt|pc))/i;if("resolve"==b){var d=this._resolveWidth(a,"style");return null!=d?d:this._resolveWidth(a,"element")}if("element"==b){var e=a.outerWidth(!1);return e<=0?"auto":e+"px"}if("style"==b){var f=a.attr("style");if("string"!=typeof f)return null;for(var g=f.split(";"),h=0,i=g.length;h<i;h+=1){var j=g[h].replace(/\s/g,""),k=j.match(c);if(null!==k&&k.length>=1)return k[1]}return null}return b},e.prototype._bindAdapters=function(){this.dataAdapter.bind(this,this.$container),this.selection.bind(this,this.$container),this.dropdown.bind(this,this.$container),this.results.bind(this,this.$container)},e.prototype._registerDomEvents=function(){var b=this;this.$element.on("change.select2",function(){b.dataAdapter.current(function(a){b.trigger("selection:update",{data:a})})}),this.$element.on("focus.select2",function(a){b.trigger("focus",a)}),this._syncA=c.bind(this._syncAttributes,this),this._syncS=c.bind(this._syncSubtree,this),this.$element[0].attachEvent&&this.$element[0].attachEvent("onpropertychange",this._syncA);var d=window.MutationObserver||window.WebKitMutationObserver||window.MozMutationObserver;null!=d?(this._observer=new d(function(c){a.each(c,b._syncA),a.each(c,b._syncS)}),this._observer.observe(this.$element[0],{attributes:!0,childList:!0,subtree:!1})):this.$element[0].addEventListener&&(this.$element[0].addEventListener("DOMAttrModified",b._syncA,!1),this.$element[0].addEventListener("DOMNodeInserted",b._syncS,!1),this.$element[0].addEventListener("DOMNodeRemoved",b._syncS,!1))},e.prototype._registerDataEvents=function(){var a=this;this.dataAdapter.on("*",function(b,c){a.trigger(b,c)})},e.prototype._registerSelectionEvents=function(){var b=this,c=["toggle","focus"];this.selection.on("toggle",function(){b.toggleDropdown()}),this.selection.on("focus",function(a){b.focus(a)}),this.selection.on("*",function(d,e){-1===a.inArray(d,c)&&b.trigger(d,e)})},e.prototype._registerDropdownEvents=function(){var a=this;this.dropdown.on("*",function(b,c){a.trigger(b,c)})},e.prototype._registerResultsEvents=function(){var a=this;this.results.on("*",function(b,c){a.trigger(b,c)})},e.prototype._registerEvents=function(){var a=this;this.on("open",function(){a.$container.addClass("select2-container--open")}),this.on("close",function(){a.$container.removeClass("select2-container--open")}),this.on("enable",function(){a.$container.removeClass("select2-container--disabled")}),this.on("disable",function(){a.$container.addClass("select2-container--disabled")}),this.on("blur",function(){a.$container.removeClass("select2-container--focus")}),this.on("query",function(b){a.isOpen()||a.trigger("open",{}),this.dataAdapter.query(b,function(c){a.trigger("results:all",{data:c,query:b})})}),this.on("query:append",function(b){this.dataAdapter.query(b,function(c){a.trigger("results:append",{data:c,query:b})})}),this.on("keypress",function(b){var c=b.which;a.isOpen()?c===d.ESC||c===d.TAB||c===d.UP&&b.altKey?(a.close(),b.preventDefault()):c===d.ENTER?(a.trigger("results:select",{}),b.preventDefault()):c===d.SPACE&&b.ctrlKey?(a.trigger("results:toggle",{}),b.preventDefault()):c===d.UP?(a.trigger("results:previous",{}),b.preventDefault()):c===d.DOWN&&(a.trigger("results:next",{}),b.preventDefault()):(c===d.ENTER||c===d.SPACE||c===d.DOWN&&b.altKey)&&(a.open(),b.preventDefault())})},e.prototype._syncAttributes=function(){this.options.set("disabled",this.$element.prop("disabled")),this.options.get("disabled")?(this.isOpen()&&this.close(),this.trigger("disable",{})):this.trigger("enable",{})},e.prototype._syncSubtree=function(a,b){var c=!1,d=this;if(!a||!a.target||"OPTION"===a.target.nodeName||"OPTGROUP"===a.target.nodeName){if(b)if(b.addedNodes&&b.addedNodes.length>0)for(var e=0;e<b.addedNodes.length;e++){var f=b.addedNodes[e];f.selected&&(c=!0)}else b.removedNodes&&b.removedNodes.length>0&&(c=!0);else c=!0;c&&this.dataAdapter.current(function(a){d.trigger("selection:update",{data:a})})}},e.prototype.trigger=function(a,b){var c=e.__super__.trigger,d={open:"opening",close:"closing",select:"selecting",unselect:"unselecting",clear:"clearing"};if(void 0===b&&(b={}),a in d){var f=d[a],g={prevented:!1,name:a,args:b};if(c.call(this,f,g),g.prevented)return void(b.prevented=!0)}c.call(this,a,b)},e.prototype.toggleDropdown=function(){this.options.get("disabled")||(this.isOpen()?this.close():this.open())},e.prototype.open=function(){this.isOpen()||this.trigger("query",{})},e.prototype.close=function(){this.isOpen()&&this.trigger("close",{})},e.prototype.isOpen=function(){return this.$container.hasClass("select2-container--open")},e.prototype.hasFocus=function(){return this.$container.hasClass("select2-container--focus")},e.prototype.focus=function(a){this.hasFocus()||(this.$container.addClass("select2-container--focus"),this.trigger("focus",{}))},e.prototype.enable=function(a){this.options.get("debug")&&window.console&&console.warn&&console.warn('Select2: The `select2("enable")` method has been deprecated and will be removed in later Select2 versions. Use $element.prop("disabled") instead.'),null!=a&&0!==a.length||(a=[!0]);var b=!a[0];this.$element.prop("disabled",b)},e.prototype.data=function(){this.options.get("debug")&&arguments.length>0&&window.console&&console.warn&&console.warn('Select2: Data can no longer be set using `select2("data")`. You should consider setting the value instead using `$element.val()`.');var a=[];return this.dataAdapter.current(function(b){a=b}),a},e.prototype.val=function(b){if(this.options.get("debug")&&window.console&&console.warn&&console.warn('Select2: The `select2("val")` method has been deprecated and will be removed in later Select2 versions. Use $element.val() instead.'),null==b||0===b.length)return this.$element.val();var c=b[0];a.isArray(c)&&(c=a.map(c,function(a){return a.toString()})),this.$element.val(c).trigger("change")},e.prototype.destroy=function(){this.$container.remove(),this.$element[0].detachEvent&&this.$element[0].detachEvent("onpropertychange",this._syncA),null!=this._observer?(this._observer.disconnect(),this._observer=null):this.$element[0].removeEventListener&&(this.$element[0].removeEventListener("DOMAttrModified",this._syncA,!1),this.$element[0].removeEventListener("DOMNodeInserted",this._syncS,!1),this.$element[0].removeEventListener("DOMNodeRemoved",this._syncS,!1)),this._syncA=null,this._syncS=null,this.$element.off(".select2"),this.$element.attr("tabindex",c.GetData(this.$element[0],"old-tabindex")),this.$element.removeClass("select2-hidden-accessible"),this.$element.attr("aria-hidden","false"),c.RemoveData(this.$element[0]),this.$element.removeData("select2"),this.dataAdapter.destroy(),this.selection.destroy(),this.dropdown.destroy(),this.results.destroy(),this.dataAdapter=null,this.selection=null,this.dropdown=null,this.results=null},e.prototype.render=function(){var b=a('<span class="select2 select2-container"><span class="selection"></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>');return b.attr("dir",this.options.get("dir")),this.$container=b,this.$container.addClass("select2-container--"+this.options.get("theme")),c.StoreData(b[0],"element",this.$element),b},e}),b.define("select2/compat/utils",["jquery"],function(a){function b(b,c,d){var e,f,g=[];e=a.trim(b.attr("class")),e&&(e=""+e,a(e.split(/\s+/)).each(function(){0===this.indexOf("select2-")&&g.push(this)})),e=a.trim(c.attr("class")),e&&(e=""+e,a(e.split(/\s+/)).each(function(){0!==this.indexOf("select2-")&&null!=(f=d(this))&&g.push(f)})),b.attr("class",g.join(" "))}return{syncCssClasses:b}}),b.define("select2/compat/containerCss",["jquery","./utils"],function(a,b){function c(a){return null}function d(){}return d.prototype.render=function(d){var e=d.call(this),f=this.options.get("containerCssClass")||"";a.isFunction(f)&&(f=f(this.$element));var g=this.options.get("adaptContainerCssClass");if(g=g||c,-1!==f.indexOf(":all:")){f=f.replace(":all:","");var h=g;g=function(a){var b=h(a);return null!=b?b+" "+a:a}}var i=this.options.get("containerCss")||{};return a.isFunction(i)&&(i=i(this.$element)),b.syncCssClasses(e,this.$element,g),e.css(i),e.addClass(f),e},d}),b.define("select2/compat/dropdownCss",["jquery","./utils"],function(a,b){function c(a){return null}function d(){}return d.prototype.render=function(d){var e=d.call(this),f=this.options.get("dropdownCssClass")||"";a.isFunction(f)&&(f=f(this.$element));var g=this.options.get("adaptDropdownCssClass");if(g=g||c,-1!==f.indexOf(":all:")){f=f.replace(":all:","");var h=g;g=function(a){var b=h(a);return null!=b?b+" "+a:a}}var i=this.options.get("dropdownCss")||{};return a.isFunction(i)&&(i=i(this.$element)),b.syncCssClasses(e,this.$element,g),e.css(i),e.addClass(f),e},d}),b.define("select2/compat/initSelection",["jquery"],function(a){function b(a,b,c){c.get("debug")&&window.console&&console.warn&&console.warn("Select2: The `initSelection` option has been deprecated in favor of a custom data adapter that overrides the `current` method. This method is now called multiple times instead of a single time when the instance is initialized. Support will be removed for the `initSelection` option in future versions of Select2"),this.initSelection=c.get("initSelection"),this._isInitialized=!1,a.call(this,b,c)}return b.prototype.current=function(b,c){var d=this;if(this._isInitialized)return void b.call(this,c);this.initSelection.call(null,this.$element,function(b){d._isInitialized=!0,a.isArray(b)||(b=[b]),c(b)})},b}),b.define("select2/compat/inputData",["jquery","../utils"],function(a,b){function c(a,b,c){this._currentData=[],this._valueSeparator=c.get("valueSeparator")||",","hidden"===b.prop("type")&&c.get("debug")&&console&&console.warn&&console.warn("Select2: Using a hidden input with Select2 is no longer supported and may stop working in the future. It is recommended to use a `<select>` element instead."),a.call(this,b,c)}return c.prototype.current=function(b,c){function d(b,c){var e=[];return b.selected||-1!==a.inArray(b.id,c)?(b.selected=!0,e.push(b)):b.selected=!1,b.children&&e.push.apply(e,d(b.children,c)),e}for(var e=[],f=0;f<this._currentData.length;f++){var g=this._currentData[f];e.push.apply(e,d(g,this.$element.val().split(this._valueSeparator)))}c(e)},c.prototype.select=function(b,c){if(this.options.get("multiple")){var d=this.$element.val();d+=this._valueSeparator+c.id,this.$element.val(d),this.$element.trigger("change")}else this.current(function(b){a.map(b,function(a){a.selected=!1})}),this.$element.val(c.id),this.$element.trigger("change")},c.prototype.unselect=function(a,b){var c=this;b.selected=!1,this.current(function(a){for(var d=[],e=0;e<a.length;e++){var f=a[e];b.id!=f.id&&d.push(f.id)}c.$element.val(d.join(c._valueSeparator)),c.$element.trigger("change")})},c.prototype.query=function(a,b,c){for(var d=[],e=0;e<this._currentData.length;e++){var f=this._currentData[e],g=this.matches(b,f);null!==g&&d.push(g)}c({results:d})},c.prototype.addOptions=function(c,d){var e=a.map(d,function(a){return b.GetData(a[0],"data")});this._currentData.push.apply(this._currentData,e)},c}),b.define("select2/compat/matcher",["jquery"],function(a){function b(b){function c(c,d){var e=a.extend(!0,{},d);if(null==c.term||""===a.trim(c.term))return e;if(d.children){for(var f=d.children.length-1;f>=0;f--){var g=d.children[f];b(c.term,g.text,g)||e.children.splice(f,1)}if(e.children.length>0)return e}return b(c.term,d.text,d)?e:null}return c}return b}),b.define("select2/compat/query",[],function(){function a(a,b,c){c.get("debug")&&window.console&&console.warn&&console.warn("Select2: The `query` option has been deprecated in favor of a custom data adapter that overrides the `query` method. Support will be removed for the `query` option in future versions of Select2."),a.call(this,b,c)}return a.prototype.query=function(a,b,c){b.callback=c,this.options.get("query").call(null,b)},a}),b.define("select2/dropdown/attachContainer",[],function(){function a(a,b,c){a.call(this,b,c)}return a.prototype.position=function(a,b,c){c.find(".dropdown-wrapper").append(b),b.addClass("select2-dropdown--below"),c.addClass("select2-container--below")},a}),b.define("select2/dropdown/stopPropagation",[],function(){function a(){}return a.prototype.bind=function(a,b,c){a.call(this,b,c);var d=["blur","change","click","dblclick","focus","focusin","focusout","input","keydown","keyup","keypress","mousedown","mouseenter","mouseleave","mousemove","mouseover","mouseup","search","touchend","touchstart"];this.$dropdown.on(d.join(" "),function(a){a.stopPropagation()})},a}),b.define("select2/selection/stopPropagation",[],function(){function a(){}return a.prototype.bind=function(a,b,c){a.call(this,b,c);var d=["blur","change","click","dblclick","focus","focusin","focusout","input","keydown","keyup","keypress","mousedown","mouseenter","mouseleave","mousemove","mouseover","mouseup","search","touchend","touchstart"];this.$selection.on(d.join(" "),function(a){a.stopPropagation()})},a}),function(c){"function"==typeof b.define&&b.define.amd?b.define("jquery-mousewheel",["jquery"],c):"object"==typeof exports?module.exports=c:c(a)}(function(a){function b(b){var g=b||window.event,h=i.call(arguments,1),j=0,l=0,m=0,n=0,o=0,p=0;if(b=a.event.fix(g),b.type="mousewheel","detail"in g&&(m=-1*g.detail),"wheelDelta"in g&&(m=g.wheelDelta),"wheelDeltaY"in g&&(m=g.wheelDeltaY),"wheelDeltaX"in g&&(l=-1*g.wheelDeltaX),"axis"in g&&g.axis===g.HORIZONTAL_AXIS&&(l=-1*m,m=0),j=0===m?l:m,"deltaY"in g&&(m=-1*g.deltaY,j=m),"deltaX"in g&&(l=g.deltaX,0===m&&(j=-1*l)),0!==m||0!==l){if(1===g.deltaMode){var q=a.data(this,"mousewheel-line-height");j*=q,m*=q,l*=q}else if(2===g.deltaMode){var r=a.data(this,"mousewheel-page-height");j*=r,m*=r,l*=r}if(n=Math.max(Math.abs(m),Math.abs(l)),(!f||n<f)&&(f=n,d(g,n)&&(f/=40)),d(g,n)&&(j/=40,l/=40,m/=40),j=Math[j>=1?"floor":"ceil"](j/f),l=Math[l>=1?"floor":"ceil"](l/f),m=Math[m>=1?"floor":"ceil"](m/f),k.settings.normalizeOffset&&this.getBoundingClientRect){var s=this.getBoundingClientRect();o=b.clientX-s.left,p=b.clientY-s.top}return b.deltaX=l,b.deltaY=m,b.deltaFactor=f,b.offsetX=o,b.offsetY=p,b.deltaMode=0,h.unshift(b,j,l,m),e&&clearTimeout(e),e=setTimeout(c,200),(a.event.dispatch||a.event.handle).apply(this,h)}}function c(){f=null}function d(a,b){return k.settings.adjustOldDeltas&&"mousewheel"===a.type&&b%120==0}var e,f,g=["wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"],h="onwheel"in document||document.documentMode>=9?["wheel"]:["mousewheel","DomMouseScroll","MozMousePixelScroll"],i=Array.prototype.slice;if(a.event.fixHooks)for(var j=g.length;j;)a.event.fixHooks[g[--j]]=a.event.mouseHooks;var k=a.event.special.mousewheel={version:"3.1.12",setup:function(){if(this.addEventListener)for(var c=h.length;c;)this.addEventListener(h[--c],b,!1);else this.onmousewheel=b;a.data(this,"mousewheel-line-height",k.getLineHeight(this)),a.data(this,"mousewheel-page-height",k.getPageHeight(this))},teardown:function(){if(this.removeEventListener)for(var c=h.length;c;)this.removeEventListener(h[--c],b,!1);else this.onmousewheel=null;a.removeData(this,"mousewheel-line-height"),a.removeData(this,"mousewheel-page-height")},getLineHeight:function(b){var c=a(b),d=c["offsetParent"in a.fn?"offsetParent":"parent"]();return d.length||(d=a("body")),parseInt(d.css("fontSize"),10)||parseInt(c.css("fontSize"),10)||16},getPageHeight:function(b){return a(b).height()},settings:{adjustOldDeltas:!0,normalizeOffset:!0}};a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})}),b.define("jquery.select2",["jquery","jquery-mousewheel","./select2/core","./select2/defaults","./select2/utils"],function(a,b,c,d,e){if(null==a.fn.select2){var f=["open","close","destroy"];a.fn.select2=function(b){if("object"==typeof(b=b||{}))return this.each(function(){var d=a.extend(!0,{},b);new c(a(this),d)}),this;if("string"==typeof b){var d,g=Array.prototype.slice.call(arguments,1);return this.each(function(){var a=e.GetData(this,"select2");null==a&&window.console&&console.error&&console.error("The select2('"+b+"') method was called on an element that is not using Select2."),d=a[b].apply(a,g)}),a.inArray(b,f)>-1?this:d}throw new Error("Invalid arguments for Select2: "+b)}}return null==a.fn.select2.defaults&&(a.fn.select2.defaults=d),c}),{define:b.define,require:b.require}}(),c=b.require("jquery.select2");return a.fn.select2.amd=b,c});
</script>
</body>
</html>