# ts-compare

> Always leave the code better than you found it. ~Robert C. Martin

Shell script to check that your are not adding TS errors to your exisitng count.

## Description

There are some projects where sadly the amount of TS errors is not 0. In such cases, you probably want to do some damage control by not letting the snowball of TS errors get bigger. 

By using this script you can **check that the amount of TS errors is less or equal between two branches.**

As of the day of writing this, `tsc` does not provide a diff functionality so this script grabs the output of `tsc` command and plays with it to get the number of errors and the diff error text.

## Installation

1. Copy and paste the script on your project on a new file.
2. Create an NPM script for ease of use:

```json
"check-types:compare": "./compare-errors.sh" 
```

### Customization: 
- Make sure that you replace npm run check:types with your tsc command.
- You can change the second branch name from master to any branch you want.


## Usage 

Execute the NPM command on your terminal:

```shell
npm run check-types:compare
```
