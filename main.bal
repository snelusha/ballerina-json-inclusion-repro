import ballerina/constraint;
import ballerina/data.jsondata;
import ballerina/io;

@constraint:String {maxLength: 3, minLength: 3}
public type CurrencyCode string;

public type Money record {
    @constraint:String {maxLength: 32, pattern: re `^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$`}
    string value;
    @jsondata:Name {value: "currency_code"}
    CurrencyCode currencyCode;
};

public type AmountBreakdown record {
    @jsondata:Name {value: "item_total"}
    Money itemTotal;
};

public type AmountWithBreakdown record {
    *Money;
    // Temporary workaround for the issue with annotations
    // @jsondata:Name {value: "currency_code"}
    // CurrencyCode currencyCode;
    AmountBreakdown breakdown?;
};

public function main() {
    AmountWithBreakdown amountWithBreakdown = {
        value: "100.00",
        currencyCode: "LKR",
        breakdown: {
            itemTotal: {
                value: "100.00",
                currencyCode: "LKR"
            }
        }
    };

    json amount = jsondata:toJson(amountWithBreakdown);

    io:println(amount);
}
