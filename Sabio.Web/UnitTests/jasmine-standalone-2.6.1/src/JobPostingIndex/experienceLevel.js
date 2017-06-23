function _convertExperienceLevelId(id) {
    var string = "";
    switch (id) {
        case 1:
            string = "Entry level";
            break;
        case 2:
            string = "Mid-level";
            break;
        case 3:
            string = "Senior level";
            break;
        default:
            break;
    }
    return string;
}