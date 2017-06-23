namespace Sabio.Web.Domain
{
    public class StateProvince : StateProvinceBase
    {
        public int CountryId { get; set; }
        public string CountryRegionCode { get; set; }
        public bool IsOnlyStateProvinceFlag { get; set; }
        public int TerritoryId { get; set; }
    }
}