(window.webpackJsonp=window.webpackJsonp||[]).push([[6],{FNKf:function(e,t,a){},oSGp:function(e,t,a){"use strict";a.r(t),a.d(t,"default",(function(){return A}));var r=a("q1tI"),n=a.n(r),o=a("uVCN"),l=a("7O5W"),i=a("17x9"),c=a.n(i);function s(e){return(s="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e})(e)}function f(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function p(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,r)}return a}function u(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?p(Object(a),!0).forEach((function(t){f(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):p(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function m(e,t){if(null==e)return{};var a,r,n=function(e,t){if(null==e)return{};var a,r,n={},o=Object.keys(e);for(r=0;r<o.length;r++)a=o[r],t.indexOf(a)>=0||(n[a]=e[a]);return n}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)a=o[r],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(n[a]=e[a])}return n}function b(e){return function(e){if(Array.isArray(e)){for(var t=0,a=new Array(e.length);t<e.length;t++)a[t]=e[t];return a}}(e)||function(e){if(Symbol.iterator in Object(e)||"[object Arguments]"===Object.prototype.toString.call(e))return Array.from(e)}(e)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance")}()}function d(e){return t=e,(t-=0)==t?e:(e=e.replace(/[\-_\s]+(.)?/g,(function(e,t){return t?t.toUpperCase():""}))).substr(0,1).toLowerCase()+e.substr(1);var t}function g(e){return e.split(";").map((function(e){return e.trim()})).filter((function(e){return e})).reduce((function(e,t){var a,r=t.indexOf(":"),n=d(t.slice(0,r)),o=t.slice(r+1).trim();return n.startsWith("webkit")?e[(a=n,a.charAt(0).toUpperCase()+a.slice(1))]=o:e[n]=o,e}),{})}var y=!1;try{y=!0}catch(F){}function h(e){return null===e?null:"object"===s(e)&&e.prefix&&e.iconName?e:Array.isArray(e)&&2===e.length?{prefix:e[0],iconName:e[1]}:"string"==typeof e?{prefix:"fas",iconName:e}:void 0}function v(e,t){return Array.isArray(t)&&t.length>0||!Array.isArray(t)&&t?f({},e,t):{}}function w(e){var t=e.forwardedRef,a=m(e,["forwardedRef"]),r=a.icon,n=a.mask,o=a.symbol,i=a.className,c=a.title,s=h(r),p=v("classes",[].concat(b(function(e){var t,a=e.spin,r=e.pulse,n=e.fixedWidth,o=e.inverse,l=e.border,i=e.listItem,c=e.flip,s=e.size,p=e.rotation,u=e.pull,m=(f(t={"fa-spin":a,"fa-pulse":r,"fa-fw":n,"fa-inverse":o,"fa-border":l,"fa-li":i,"fa-flip-horizontal":"horizontal"===c||"both"===c,"fa-flip-vertical":"vertical"===c||"both"===c},"fa-".concat(s),null!=s),f(t,"fa-rotate-".concat(p),null!=p&&0!==p),f(t,"fa-pull-".concat(u),null!=u),f(t,"fa-swap-opacity",e.swapOpacity),t);return Object.keys(m).map((function(e){return m[e]?e:null})).filter((function(e){return e}))}(a)),b(i.split(" ")))),d=v("transform","string"==typeof a.transform?l.parse.transform(a.transform):a.transform),g=v("mask",h(n)),O=Object(l.icon)(s,u({},p,{},d,{},g,{symbol:o,title:c}));if(!O)return function(){var e;!y&&console&&"function"==typeof console.error&&(e=console).error.apply(e,arguments)}("Could not find icon",s),null;var E=O.abstract,N={ref:t};return Object.keys(a).forEach((function(e){w.defaultProps.hasOwnProperty(e)||(N[e]=a[e])})),x(E[0],N)}w.displayName="FontAwesomeIcon",w.propTypes={border:c.a.bool,className:c.a.string,mask:c.a.oneOfType([c.a.object,c.a.array,c.a.string]),fixedWidth:c.a.bool,inverse:c.a.bool,flip:c.a.oneOf(["horizontal","vertical","both"]),icon:c.a.oneOfType([c.a.object,c.a.array,c.a.string]),listItem:c.a.bool,pull:c.a.oneOf(["right","left"]),pulse:c.a.bool,rotation:c.a.oneOf([0,90,180,270]),size:c.a.oneOf(["lg","xs","sm","1x","2x","3x","4x","5x","6x","7x","8x","9x","10x"]),spin:c.a.bool,symbol:c.a.oneOfType([c.a.bool,c.a.string]),title:c.a.string,transform:c.a.oneOfType([c.a.string,c.a.object]),swapOpacity:c.a.bool},w.defaultProps={border:!1,className:"",mask:null,fixedWidth:!1,inverse:!1,flip:null,icon:null,listItem:!1,pull:null,pulse:!1,rotation:null,size:null,spin:!1,symbol:!1,title:"",transform:null,swapOpacity:!1};var x=function e(t,a){var r=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};if("string"==typeof a)return a;var n=(a.children||[]).map((function(a){return e(t,a)})),o=Object.keys(a.attributes||{}).reduce((function(e,t){var r=a.attributes[t];switch(t){case"class":e.attrs.className=r,delete a.attributes.class;break;case"style":e.attrs.style=g(r);break;default:0===t.indexOf("aria-")||0===t.indexOf("data-")?e.attrs[t.toLowerCase()]=r:e.attrs[d(t)]=r}return e}),{attrs:{}}),l=r.style,i=void 0===l?{}:l,c=m(r,["style"]);return o.attrs.style=u({},o.attrs.style,{},i),t.apply(void 0,[a.tag,u({},o.attrs,{},c)].concat(b(n)))}.bind(null,n.a.createElement),O=a("8tEE"),E=a("vOnD"),N=E.b.div.withConfig({displayName:"Tooltip__Root",componentId:"sc-18gwgxv-0"})(["position:relative;display:inline;"]),j=E.b.div.withConfig({displayName:"Tooltip__TooltipBody",componentId:"sc-18gwgxv-1"})(['position:absolute;background-color:#fff;box-shadow:0 8px 42px rgba(41,71,124,0.34);border-radius:15px;transition:all 0.1s ease-out;opacity:0;pointer-events:none;z-index:10;&.triggered{opacity:1;pointer-events:all;}&:after{content:"";background-color:transparent;display:block;position:absolute;pointer-events:none;border-color:transparent;border-style:solid;width:0;height:0;border-width:8px;}&[data-relation="top"]{bottom:calc(100% - 20px);&.triggered{bottom:calc(100% + 10px);}&:after{top:100%;border-top-color:#fff;}}&[data-relation="bottom"]{top:calc(100% - 20px);&.triggered{top:calc(100% + 10px);}&:after{bottom:100%;border-bottom-color:#fff;}}&[data-relation="bottom"],&[data-relation="top"]{left:50%;&[data-position="1"]{transform:translateX(calc(-100% + 30px)) scale(0.8);&.triggered{transform:translateX(calc(-100% + 20px)) scale(1);}&:after{right:15px;}}&[data-position="2"]{transform:translateX(-50%) scale(0.8);&.triggered{transform:translateX(-50%) scale(1);}&:after{left:50%;transform:translateX(-50%);}}&[data-position="3"]{transform:translateX(calc(0% - 40px)) scale(0.8);&.triggered{transform:translateX(calc(0% - 20px)) scale(1);}&:after{left:15px;}}}&[data-relation="left"]{right:calc(100% - 20px);&.triggered{right:calc(100% + 20px);}&:after{left:100%;border-left-color:#fff;}}&[data-relation="right"]{left:calc(100% - 20px);&.triggered{left:calc(100% + 20px);}&:after{right:100%;border-right-color:#fff;}}&[data-relation="right"],&[data-relation="left"]{top:50%;&[data-position="1"]{transform:translateY(calc(-100% + 40px)) scale(0.8);&.triggered{transform:translateY(calc(-100% + 20px));}&:after{bottom:15px;}}&[data-position="2"]{transform:translateY(-50%) scale(0.8);&.triggered{transform:translateY(-50%);}&:after{top:50%;transform:translateY(-50%);}}&[data-position="3"]{transform:translateY(calc(0% - 40px)) scale(0.8);&.triggered{transform:translateY(calc(0% - 20px));}&:after{top:15px;}}}']),k=function(e){var t=e.relation,a=e.content,r=e.position,o=e.children,l=e.className,i=e.title,c=n.a.useState(!1),s=c[0],f=c[1],p=n.a.useRef(null);return n.a.useEffect((function(){var e=function(e){var t=e.target;p.current&&!p.current.contains(t)&&f(!1)};return window.addEventListener("click",e),function(){return window.removeEventListener("click",e)}}),[f]),n.a.createElement(N,{className:l,title:i,ref:p},o(f),n.a.createElement(j,{"data-relation":t,"data-position":r,className:s&&" triggered"},a))};a("FNKf");function A(){var e=new Date(Date.UTC(2020,8,16,20,0)),t=new Intl.DateTimeFormat("en",{hour:"numeric",minute:"numeric"}).format(e);return n.a.createElement(o.b,{title:"Flamecon - Flame engine online conference",fullWitdh:!0},n.a.createElement("div",{className:"flamecon-wrapper"},n.a.createElement("div",{className:"flamecon-inner"},n.a.createElement("h1",{className:"flamecon-title"},"FLAMECON"),n.a.createElement("div",{className:"flamecon-tagline"},"Flutter game engine conference"),n.a.createElement("div",{className:"flamecon-lineup"},n.a.createElement("p",{className:"flamecon-datetime"},n.a.createElement("b",null,"16 Sept")," at"," ",n.a.createElement(k,{position:2,relation:"top",content:n.a.createElement("p",{className:"flamecon-localtime"},"This is ",t," for you")},(function(e){return n.a.createElement("b",{onMouseEnter:function(){return e(!0)},onMouseLeave:function(){return e(!1)},className:"flamecon-utc",title:"This is "+t+" for you"},"8PM UTC")})),":"),n.a.createElement("div",{className:"flamecon-talk"},"Building RPG games with\u2029"," ",n.a.createElement("a",{className:"flamecon-boom",title:"Bonfire",target:"_blank",href:"https://bonfire-engine.github.io/"},"Bonfire"),n.a.createElement("a",{href:"https://github.com/RafaelBarbosatec/bonfire"},n.a.createElement(w,{icon:O.a})),n.a.createElement("a",{className:"flamecon-author",href:"https://github.com/erickzanardo",target:"_blank"},"Rafael Barbosa")),n.a.createElement("div",{className:"flamecon-talk"},"Optimizing sprite usage with\u2029"," ",n.a.createElement("a",{className:"flamecon-boom",title:"Fire Atlas",target:"_blank",href:"https://fire-atlas.flame-engine.org/"},"Fire Atlas"),n.a.createElement("a",{href:"https://github.com/flame-engine/fire-atlas"},n.a.createElement(w,{icon:O.a})),n.a.createElement("a",{className:"flamecon-author",href:"https://github.com/RafaelBarbosatec",target:"_blank"},"Erick Zanardo"))),n.a.createElement("p",{className:"flamecon-join"},"Join us at:"," ",n.a.createElement("a",{href:"https://www.meetup.com/FlameCon/"},n.a.createElement(w,{icon:O.b}))," ",n.a.createElement("a",{href:"https://www.youtube.com/channel/UCinjCGNThGXbUYFgfgsI0bA"},n.a.createElement(w,{icon:O.c}))),n.a.createElement("a",{className:"flamecon-cta",target:"_blank",href:"http://www.google.com/calendar/event?action=TEMPLATE&dates=20200916T200000Z%2F20200916T220000Z&text=Flamecon&location=&details=First%20iteration%20of%20FlameCon%2C%20an%20open%2C%20online%20community%20event%20to%20gather%20people%20that%20use%20and%20love%20Flame%2C%20the%20Flutter%20game%20engine.%0A%0AMore%20details%3A%20http%3A%2F%2Fflame-engine.org%2Fflamecon"},"Save the date"))))}}}]);
//# sourceMappingURL=component---src-templates-flamecon-template-js-e6ab0e06a136b5843f57.js.map