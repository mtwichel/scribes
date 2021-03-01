<h1 align="center" style="border-bottom: 0px">✍️✍️ Scribes ✍️✍️</h1>

<p align="center">
<a href="https://pub.dev/packages/scribes"><img src="https://img.shields.io/pub/v/scribes.svg" alt="Pub"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

---

> Like a team of middle-ages monks, scribes allows developers to define their whole library of data objects, then transcribe them into other languages.

**NOTE! This package is pre-release and may not work as intended. Use at your own risk.**

## Quick Start

Install with the following command:

```bash
$ pub global activate scribes
```

Then run:

```bash
$ scribes init
```

which will create example objects. Then run:

```bash
$ scribes transcribe
```

Which will generate dart and typescript objects.

## Usage

You can define objects in a YAML file ending in `.objects.yaml`. Use the format described in [Defining Objects](#defining-objects).

You can also download the [schema.json file](https://raw.githubusercontent.com/mtwichel/scribes/main/schema.json) and add it to your IDE for auto-completion.

### Generating files

To generate source code, run the following command:

```bash
$ scribes transcribe
```

**Options**

- `--no-typescript` and `--no-dart`: flags that can be added if you wish to omit generating certain languages.
- `--objects [PATH]`: An alternate path to the folder your objects files are stored.
- `--dart-path [PATH]` and `--typescript-path [PATH]`: A alternate path to the folder where different object files should be generated.

## Defining Objects

#### Data Objects

Data objects are objects that can be represented as JSON, with a description. For example:

```yaml
Customer:
  description: A customer registered to the loyalty program.
  properties:
    - id:
        type: string
        description: The unique guid for this customer.
    - First Name:
        type: string
        description: The first name of the customer.
    - Last Name:
        type: string
        description: The last name of the customer.
    - Email Address:
        type: string
        description: The email address of the customer.
```

Each property must have a description and a type.

### Types

Objects support the following types:

- string
- double
- integer
- boolean
- list
- enum
- object

#### Primative types

For `string`, `double`, `integer`, and `boolean`, simply use those keywords as the property's type.

Example:

```yaml
Car:
  description: A car that can be registered to a driver.
  properties:
    - id:
        type: string
        description: The unique guid for this car.
```

#### List type

For `list`, specify the type of elements of the list using the syntax `list of [ELEMENT TYPE]`.

Example:

```yaml
Car:
  description: A car that can be registered to a driver.
  properties:
    - drivers:
        type: list of string
        description: The names of the drivers registered to drive this car.
```

#### Object and Enum types

For `object` and `enum` types, simply specify the name of the object or enum in the type field. **NOTE: If an object is not found with the specified name, an error will be thrown.**

```yaml
Car:
  description: A car that can be registered to a driver.
  properties:
    - Primary driver:
        type: Driver
        description: The primary driver that registered the car.
    - Color:
        type: Car Color
        description: The color of the car.
Driver:
  description: A person with a valid drivers license.
  properties:
    - First Name:
        type: string
        description: The fist name of the driver.
Car Color:
  description: A color that the majority of a car is colored.
  type: enum
  enumValues:
    - val: Blue
      description: A blue car.
    - val: Red
      description: A red car.
    - val: Black
      description: A black car.
```

### Enums

An enum is an object with a set of discrete values. They have a description, as well as a number of values.

They can also take a `unknownValue`, which will be used if a value is not recognized as a valid member of the enum.

Example:

```yaml
Ice Cream Flavor:
  description: A flavor of ice cream.
  type: enum
  unknownValue: Unknown
  enumValues:
    - val: Chocolate
      description: Chocolate ice cream.
    - val: Vanilla
      description: Vanilla ice cream.
    - val: Mint chocolate chip
      description: Mint chocolate chip ice cream.
```
