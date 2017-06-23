
describe("USAJOBS Days Ago String Builder", function () {
    it("Should convert yesterday's date to '1 Day Ago'", function () {
        var jobPosting = {
            MatchedObjectDescriptor: {
                PublicationStartDate: "2017-05-17"
            }
        };
        expect(_usaJobsDaysAgoStringBuilder(jobPosting)).toEqual("1 day ago");
    });
    it("Should convert last day of last month to '[today's date] days ago'", function () {
        var jobPosting = {
            MatchedObjectDescriptor: {
                PublicationStartDate: "2017-04-30"
            }
        };
        expect(_usaJobsDaysAgoStringBuilder(jobPosting)).toEqual("18 days ago");
    });
});