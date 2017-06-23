describe("Days Ago String Builder", function () {
    it("Should convert date object into days ago string", function () {

        var yesterday = "2017-05-17T00:00:00.00";
        var twoDaysAgo = "2017-05-16T00:00:00.00";

        expect(_daysAgoStringBuilder(yesterday)).toEqual("1 day ago");
        expect(_daysAgoStringBuilder(twoDaysAgo)).toEqual("2 days ago");
    })
})