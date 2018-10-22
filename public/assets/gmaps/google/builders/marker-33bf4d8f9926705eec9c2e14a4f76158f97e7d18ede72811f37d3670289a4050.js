(function(){var i=function(i,t){return function(){return i.apply(t,arguments)}},t=function(i,t){function r(){this.constructor=i}for(var o in t)n.call(t,o)&&(i[o]=t[o]);return r.prototype=t.prototype,i.prototype=new r,i.__super__=t.prototype,i},n={}.hasOwnProperty;this.Gmaps.Google.Builders.Marker=function(n){function r(t,n,r){this.args=t,this.provider_options=null!=n?n:{},this.internal_options=null!=r?r:{},this.infowindow_binding=i(this.infowindow_binding,this),this.before_init(),this.create_marker(),this.create_infowindow_on_click(),this.after_init()}return t(r,n),r.CURRENT_INFOWINDOW=void 0,r.CACHE_STORE={},r.prototype.build=function(){return this.marker=new(this.model_class())(this.serviceObject)},r.prototype.create_marker=function(){return this.serviceObject=new(this.primitives().marker)(this.marker_options())},r.prototype.create_infowindow=function(){return _.isString(this.args.infowindow)?new(this.primitives().infowindow)({content:this.args.infowindow}):null},r.prototype.marker_options=function(){var i,t;return t=this._randomized_coordinates(),i={title:this.args.marker_title,position:new(this.primitives().latLng)(t[0],t[1]),icon:this._get_picture("picture"),shadow:this._get_picture("shadow")},_.extend(this.provider_options,i)},r.prototype.create_infowindow_on_click=function(){return this.addListener("click",this.infowindow_binding)},r.prototype.infowindow_binding=function(){var i;if(this._should_close_infowindow()&&this.constructor.CURRENT_INFOWINDOW.close(),this.marker.panTo(),null==this.infowindow&&(this.infowindow=this.create_infowindow()),null!=this.infowindow)return this.infowindow.open(this.getServiceObject().getMap(),this.getServiceObject()),null==(i=this.marker).infowindow&&(i.infowindow=this.infowindow),this.constructor.CURRENT_INFOWINDOW=this.infowindow},r.prototype._get_picture=function(i){return _.isObject(this.args[i])&&_.isString(this.args[i].url)?this._create_or_retrieve_image(this._picture_args(i)):null},r.prototype._create_or_retrieve_image=function(i){return void 0===this.constructor.CACHE_STORE[i.url]&&(this.constructor.CACHE_STORE[i.url]=new(this.primitives().markerImage)(i.url,i.size,i.origin,i.anchor,i.scaledSize)),this.constructor.CACHE_STORE[i.url]},r.prototype._picture_args=function(i){return{url:this.args[i].url,anchor:this._createImageAnchorPosition(this.args[i].anchor),size:new(this.primitives().size)(this.args[i].width,this.args[i].height),scaledSize:null,origin:null}},r.prototype._createImageAnchorPosition=function(i){return _.isArray(i)?new(this.primitives().point)(i[0],i[1]):null},r.prototype._should_close_infowindow=function(){return this.internal_options.singleInfowindow&&null!=this.constructor.CURRENT_INFOWINDOW},r.prototype._randomized_coordinates=function(){var i,t,n,r,o;return _.isNumber(this.internal_options.maxRandomDistance)?(o=function(){return 2*Math.random()-1},n=this.internal_options.maxRandomDistance*o(),r=this.internal_options.maxRandomDistance*o(),i=parseFloat(this.args.lat)+180/Math.PI*(r/6378137),t=parseFloat(this.args.lng)+90/Math.PI*(n/6378137)/Math.cos(this.args.lat),[i,t]):[this.args.lat,this.args.lng]},r}(Gmaps.Objects.BaseBuilder)}).call(this);