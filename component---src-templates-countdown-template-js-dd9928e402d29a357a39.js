(window.webpackJsonp=window.webpackJsonp||[]).push([[6],{IP2g:function(t,e,r){"use strict";r.d(e,"a",(function(){return w}));var n=r("7O5W"),a=r("17x9"),o=r.n(a),i=r("q1tI"),l=r.n(i);function c(t){return(c="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t})(t)}function s(t,e,r){return e in t?Object.defineProperty(t,e,{value:r,enumerable:!0,configurable:!0,writable:!0}):t[e]=r,t}function u(t,e){var r=Object.keys(t);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(t);e&&(n=n.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),r.push.apply(r,n)}return r}function f(t){for(var e=1;e<arguments.length;e++){var r=null!=arguments[e]?arguments[e]:{};e%2?u(Object(r),!0).forEach((function(e){s(t,e,r[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(r)):u(Object(r)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(r,e))}))}return t}function p(t,e){if(null==t)return{};var r,n,a=function(t,e){if(null==t)return{};var r,n,a={},o=Object.keys(t);for(n=0;n<o.length;n++)r=o[n],e.indexOf(r)>=0||(a[r]=t[r]);return a}(t,e);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(t);for(n=0;n<o.length;n++)r=o[n],e.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(t,r)&&(a[r]=t[r])}return a}function b(t){return function(t){if(Array.isArray(t)){for(var e=0,r=new Array(t.length);e<t.length;e++)r[e]=t[e];return r}}(t)||function(t){if(Symbol.iterator in Object(t)||"[object Arguments]"===Object.prototype.toString.call(t))return Array.from(t)}(t)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance")}()}function y(t){return e=t,(e-=0)==e?t:(t=t.replace(/[\-_\s]+(.)?/g,(function(t,e){return e?e.toUpperCase():""}))).substr(0,1).toLowerCase()+t.substr(1);var e}function m(t){return t.split(";").map((function(t){return t.trim()})).filter((function(t){return t})).reduce((function(t,e){var r,n=e.indexOf(":"),a=y(e.slice(0,n)),o=e.slice(n+1).trim();return a.startsWith("webkit")?t[(r=a,r.charAt(0).toUpperCase()+r.slice(1))]=o:t[a]=o,t}),{})}var d=!1;try{d=!0}catch(h){}function O(t){return null===t?null:"object"===c(t)&&t.prefix&&t.iconName?t:Array.isArray(t)&&2===t.length?{prefix:t[0],iconName:t[1]}:"string"==typeof t?{prefix:"fas",iconName:t}:void 0}function v(t,e){return Array.isArray(e)&&e.length>0||!Array.isArray(e)&&e?s({},t,e):{}}function w(t){var e=t.forwardedRef,r=p(t,["forwardedRef"]),a=r.icon,o=r.mask,i=r.symbol,l=r.className,c=r.title,u=O(a),y=v("classes",[].concat(b(function(t){var e,r=t.spin,n=t.pulse,a=t.fixedWidth,o=t.inverse,i=t.border,l=t.listItem,c=t.flip,u=t.size,f=t.rotation,p=t.pull,b=(s(e={"fa-spin":r,"fa-pulse":n,"fa-fw":a,"fa-inverse":o,"fa-border":i,"fa-li":l,"fa-flip-horizontal":"horizontal"===c||"both"===c,"fa-flip-vertical":"vertical"===c||"both"===c},"fa-".concat(u),null!=u),s(e,"fa-rotate-".concat(f),null!=f&&0!==f),s(e,"fa-pull-".concat(p),null!=p),s(e,"fa-swap-opacity",t.swapOpacity),e);return Object.keys(b).map((function(t){return b[t]?t:null})).filter((function(t){return t}))}(r)),b(l.split(" ")))),m=v("transform","string"==typeof r.transform?n.parse.transform(r.transform):r.transform),h=v("mask",O(o)),j=Object(n.icon)(u,f({},y,{},m,{},h,{symbol:i,title:c}));if(!j)return function(){var t;!d&&console&&"function"==typeof console.error&&(t=console).error.apply(t,arguments)}("Could not find icon",u),null;var x=j.abstract,P={ref:e};return Object.keys(r).forEach((function(t){w.defaultProps.hasOwnProperty(t)||(P[t]=r[t])})),g(x[0],P)}w.displayName="FontAwesomeIcon",w.propTypes={border:o.a.bool,className:o.a.string,mask:o.a.oneOfType([o.a.object,o.a.array,o.a.string]),fixedWidth:o.a.bool,inverse:o.a.bool,flip:o.a.oneOf(["horizontal","vertical","both"]),icon:o.a.oneOfType([o.a.object,o.a.array,o.a.string]),listItem:o.a.bool,pull:o.a.oneOf(["right","left"]),pulse:o.a.bool,rotation:o.a.oneOf([0,90,180,270]),size:o.a.oneOf(["lg","xs","sm","1x","2x","3x","4x","5x","6x","7x","8x","9x","10x"]),spin:o.a.bool,symbol:o.a.oneOfType([o.a.bool,o.a.string]),title:o.a.string,transform:o.a.oneOfType([o.a.string,o.a.object]),swapOpacity:o.a.bool},w.defaultProps={border:!1,className:"",mask:null,fixedWidth:!1,inverse:!1,flip:null,icon:null,listItem:!1,pull:null,pulse:!1,rotation:null,size:null,spin:!1,symbol:!1,title:"",transform:null,swapOpacity:!1};var g=function t(e,r){var n=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};if("string"==typeof r)return r;var a=(r.children||[]).map((function(r){return t(e,r)})),o=Object.keys(r.attributes||{}).reduce((function(t,e){var n=r.attributes[e];switch(e){case"class":t.attrs.className=n,delete r.attributes.class;break;case"style":t.attrs.style=m(n);break;default:0===e.indexOf("aria-")||0===e.indexOf("data-")?t.attrs[e.toLowerCase()]=n:t.attrs[y(e)]=n}return t}),{attrs:{}}),i=n.style,l=void 0===i?{}:i,c=p(n,["style"]);return o.attrs.style=f({},o.attrs.style,{},l),e.apply(void 0,[r.tag,f({},o.attrs,{},c)].concat(b(a)))}.bind(null,l.a.createElement)},"cu+B":function(t,e,r){},qpxY:function(t,e,r){"use strict";r.r(e),r.d(e,"default",(function(){return c}));var n=r("q1tI"),a=r.n(n),o=r("uVCN"),i=r("IP2g"),l=r("wHSu");r("cu+B");function c(){var t=Object(n.useState)(null),e=t[0],r=t[1];Object(n.useEffect)((function(){var t=new URLSearchParams(window.location.search),e=(new Date).getTime(),n=t.get("timestamp")||e;r((n-e)/1e3)}),[]),Object(n.useEffect)((function(){e&&setTimeout((function(){return r(e-1)}),1e3)}),[e]);var c;return a.a.createElement(o.b,{title:"Countdown",fullWitdh:!0},a.a.createElement("div",{className:"flame-logo-wrapper"},a.a.createElement("div",{className:"flame-logo-inner countdown"},a.a.createElement(i.a,{icon:l.a}),a.a.createElement("p",null,(c=e)?function(t){return Math.ceil(t/60)}(c)+":"+function(t){return(""+Math.abs(Math.round(t%60))).padStart(2,"0")}(c):"-"))))}}}]);
//# sourceMappingURL=component---src-templates-countdown-template-js-dd9928e402d29a357a39.js.map