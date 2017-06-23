describe("USAJOBS Remuneration String Builder", function () {
    it("Should convert min, max and rate to string", function () {
        var positionRemuneration = {
            MinimumRange: 40000,
            MaximumRange: 100000,
            RateIntervalCode: "Per Year"
        };
        expect(_usaJobsRemunerationStringBuilder(positionRemuneration)).toEqual("$40,000 - $100,000 per year");
        var positionRemuneration2 = {
            MinimumRange: 25,
            MaximumRange: 40,
            RateIntervalCode: "Per Hour"
        };
        expect(_usaJobsRemunerationStringBuilder(positionRemuneration2)).toEqual("$25 - $40 per hour");
    })
})