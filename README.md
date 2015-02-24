Polymer Intl
====

This package provides Intl transformer for Polymer and generator ARB<=>Dart.

## Try It Now
Add the polymer_intl.dart package to your pubspec.yaml file:

```yaml
dependencies:
  polymer_intl: ">=0.0.1 <0.1.0"
```

## Building and Deploying
To build a deployable version of your app, add the polymer_intl transformers before polymer transformers to your pubspec.yaml file:

transformers:
- polymer_intl

## Overview

Polymer Intl allow you to write complex intl expressions:

```html
<link rel="import" href="../../packages/polymer_intl/i18n.html">
    <!-- code -->
    
    <i18n-message id="msg1">
      <value>Your name: $userName</value>
      <meaning>Showing user name</meaning>
      <arg id="userName" example="Igor">{{ model.firstName }}</arg>
      <desc>Show user name in admin panel</desc>
    </i18n-message>
```

In result html:

```html
<link rel="import" href="../../packages/polymer_intl/i18n.html">
    <!-- code -->
    
    {{message_msg1(model.firstName)}}
```

### Features
 * generate arb from dart
 * generate dart from arb
 * inject method in dart code
 * support pub serve
 * support dart2js
 * intl package:
 ** message
 ** plural
 ** select
 ** gender
 