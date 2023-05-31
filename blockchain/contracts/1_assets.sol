// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract InvestorAssets {
    struct Asset {
        uint256 id;
        uint256 investorId;
        uint256 pickId;
        uint256 quantity;
        uint256 price;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public assetCount;

    event AssetAdded(uint256 assetId);

    function addAsset(
        uint256 assetId,
        uint256 investorId,
        uint256 pickId,
        uint256 quantity,
        uint256 price
    ) public {
        assetCount++;
        assets[assetCount] = Asset(
            assetId,
            investorId,
            pickId,
            quantity,
            price
        );
        emit AssetAdded(assetCount);
    }

    function getAssetsByInvestor(uint256 investorId)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory investorAssets = new uint256[](assetCount);
        uint256 count = 0;
        for (uint256 i = 1; i <= assetCount; i++) {
            if (assets[i].investorId == investorId) {
                investorAssets[count] = assets[i].id;
                count++;
            }
        }
        uint256[] memory result = new uint256[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = investorAssets[i];
        }
        return result;
    }

    function getAssetById(uint256 assetId) public view returns (uint256, uint256, uint256, uint256, uint256) {
            Asset storage asset = assets[assetId];
            return (
                asset.id,
                asset.investorId,
                asset.pickId,
                asset.quantity,
                asset.price
            );
    }


}
