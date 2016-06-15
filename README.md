# ng-eternicode-datepicker
AngularJS wrapper for the awesome [bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker) by [@eternicode](https://github.com/eternicode).

## Installation
**bower**
````
bower install ng-eternicode-datepicker --save
````

**npm**
````
npm install ng-eternicode-datepicker --save
````

**Other**  
Download file `dist/ng-eternicode-datepicker.min.js`

### Include files
The original `bootstrap-datepicker` files have to be included first. These files are required:
```html
<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker3.min.css">

<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script src="bower_components/angular/angular.min.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="bower_components/ng-eternicode-datepicker/dist/ng-eternicode-datepicker.js"></script>
```
If you want to use other language remember to include the appropriate bootstrap-datepicker language file. For example:
```html
<script src="bower_components/bootstrap-datepicker/dist/locales/bootstrap-datepicker.de.min.js"></script>
```

## Usage
Remember to add the module `fk.eternicode-datepicker`as a dependency to your angular module:
```js
angular.module('yourApp', ['fk.eternicode-datepicker']);
```

### Text input
```html
<div datepicker ng-model="dateInput">
  <input type="text" class="form-control">
</div>
```
**!! ATTENTION !!**  
You can't apply `datepicker` and `ng-model` directly to an input field.  
As the `bootstrap-datepicker` changes the value of the input field, this would mess around with our model.

### Component
```html
<div class="input-group date" datepicker ng-model='dateComponent'>
  <input type="text" class="form-control">
  <span class="input-group-addon">
    <i class="glyphicon glyphicon-th"></i>
  </span>
</div>
```

### Embedded / Inline
```html
<div datepicker ng-model='dateEmbedded'></div>
```

### Range
*Currently not supported*.

## Options
Too pass additional datepicker options use the `dp-options` attribute:
```html
<div datepicker ng-model="dateInput" dp-option="datepickerOptions">
  <input type="text" class="form-control">
</div>
```
```js
// Inside your controller
$scope.datepickerOptions = {
  autoclose: true
};
```

Please refer to the [bootstrap-datepicker docs](https://bootstrap-datepicker.readthedocs.io/en/latest/options.html) to learn more about supported options.

### datepickerDefaultsProvider
Many options will be the same for every datepicker in your app. At least the language and date format should be consinstent. For this reason you could set default options which are used for every datepicker with the `datepickerDefaultsProvider`.
```js
angular.module('yourApp')
  .config(['datepickerDefaultsProvider', function (datepickerDefaultsProvider) {
    datepickerDefaultsProvider.setDefaultOptions({
      language: 'de',
      format: 'dd.mm.yyyy',
      assumeNearbyYear: true,
      autoclose: true,
      todayHighlight: true
    });
  });
```
Ofcourse you could override or extend your defaults with the `dp-options` attribute.

## Todo
 - Tests
 - Angular form validation

## Licence
MIT
