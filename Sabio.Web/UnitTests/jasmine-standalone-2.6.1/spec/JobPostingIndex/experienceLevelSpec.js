
describe("Experience Level", function () {
    it("should convert experience level id to string", function () {
        expect(_convertExperienceLevelId(1)).toEqual("Entry level");
        expect(_convertExperienceLevelId(2)).toEqual("Mid-level");
        expect(_convertExperienceLevelId(3)).toEqual("Senior level");
    });
});