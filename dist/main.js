!function(e,r){"function"==typeof define&&define.amd?define(r):"object"==typeof exports?module.exports=r(require,exports,module):e.gulpWrapUmd=r()}(this,function(){var e,r,t={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",decodeArrayBuffer:function(e){var r=e.length/4*3,t=new ArrayBuffer(r);return this.decode(e,t),t},decode:function(e,r){var t=this._keyStr.indexOf(e.charAt(e.length-1)),n=this._keyStr.indexOf(e.charAt(e.length-2)),i=e.length/4*3;64==t&&i--,64==n&&i--;var a,c,d,f,h,o,l,u,s=0,A=0;for(a=r?new Uint8Array(r):new Uint8Array(i),e=e.replace(/[^A-Za-z0-9\+\/=]/g,""),s=0;i>s;s+=3)h=this._keyStr.indexOf(e.charAt(A++)),o=this._keyStr.indexOf(e.charAt(A++)),l=this._keyStr.indexOf(e.charAt(A++)),u=this._keyStr.indexOf(e.charAt(A++)),c=h<<2|o>>4,d=(15&o)<<4|l>>2,f=(3&l)<<6|u,a[s]=c,64!=l&&(a[s+1]=d),64!=u&&(a[s+2]=f);return a}};return e=function(r){var t;return t=r.length,0===t?0:r[t-1]+(e(r.slice(0,t-1))<<8)},r=function(r){var n,i,a,c,d;return r=r.replace(/\r?\n/g,""),r=null!=(d=/AAAAB3NzaC1yc2E[A-Za-z0-9+\/=]+/.exec(r))?d[0]:void 0,null==r?"Missing header.":(n=t.decode(r),a=e(n.slice(11,15)),i=15+a,c=e(n.slice(i,+(i+3)+1||9e9)),i+=4+c,i!==n.length?"Invalid key length.":!0)}});