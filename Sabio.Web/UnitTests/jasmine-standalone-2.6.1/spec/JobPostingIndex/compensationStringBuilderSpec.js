describe("Compensation String Builder", function () {
    it("should return a string, given a number and rate id", function () {
        expect(_compensationStringBuilder(50000, 3)).toEqual('$50,000 per year');
        expect(_compensationStringBuilder(500, 2)).toEqual('$500 per day');
        expect(_compensationStringBuilder(50, 1)).toEqual('$50.00 per hour');
    })
})