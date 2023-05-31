import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Storage {
  bool isLoading = true;
  final String _rpcUrl = "http://192.168.31.100:7545";

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _getNum, _setNum;

  init() async {
    await getAbi();
    await initializeWeb3Client();
    await getCreadentials();
    await getDeployedContract();
  }

  getBalanace() async {
    return await _client.getBalance(_credentials.address);
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("assets/abi/Storage.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCreadentials() async {
    _credentials = EthPrivateKey.fromHex(
        '0x486800b3fa93c659155c6c029c68ad79d32f9a46689bd7b4489b20049b93588b');
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Storage"), _contractAddress);
    _setNum = _contract.function("store");
    _getNum = _contract.function("retrieve");
  }

  Future<void> initializeWeb3Client() async {
    final httpClient = Client();
    _client = Web3Client(_rpcUrl, httpClient);
  }

  setNumber(int num) async {
    isLoading = true;
    BigInt cId = await _client.getChainId();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          from: EthereumAddress.fromHex(
              '0xc35c4F0774E9987360a42a82a5675C3671abe2EA'),
          contract: _contract,
          function: _setNum,
          parameters: [BigInt.from(num)],
        ),
        chainId: cId.toInt());
  }

  getNumber() async {
    isLoading = true;
    BigInt cId = await _client.getChainId();

    return await _client.call(
      contract: _contract,
      function: _getNum,
      params: [],
    );
  }
}

class AssetInBlockChain {
  int assetId, investorId, pickId, quantity, price;
  AssetInBlockChain(
      this.assetId, this.investorId, this.pickId, this.quantity, this.price);
}

class BlockChainAsset {
  final String _rpcUrl = "http://192.168.31.100:7545";
  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;
  late ContractFunction _addAsset, _getAssetsById, _getAssetsByInvestorId;

  connect() async {
    await getAbi();
    await initializeWeb3Client();
    await getCreadentials();
    await getDeployedContract();
  }

  getBalanace() async {
    return await _client.getBalance(_credentials.address);
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("assets/abi/InvestorAssets.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCreadentials() async {
    _credentials = EthPrivateKey.fromHex(
        '0xe9801f73fd3c7e266080238d4f0477f1975288dfca462b94a640d478aad4f156');
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "InvestorAssets"), _contractAddress);
    _addAsset = _contract.function("addAsset");
    _getAssetsByInvestorId = _contract.function("getAssetsByInvestor");
    _getAssetsById = _contract.function("getAssetById");
  }

  Future<void> initializeWeb3Client() async {
    final httpClient = Client();
    _client = Web3Client(_rpcUrl, httpClient);
  }

  addAsset(AssetInBlockChain asset) async {
    BigInt? cId = await _client.getChainId();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          from: EthereumAddress.fromHex(
              '0x3aCEc4483eb83E5f166D4CD21177f3696b19e093'),
          contract: _contract,
          function: _addAsset,
          parameters: [
            BigInt.from(asset.assetId),
            BigInt.from(asset.investorId),
            BigInt.from(asset.pickId),
            BigInt.from(asset.quantity),
            BigInt.from(asset.price)
          ],
        ),
        chainId: cId.toInt());
  }

  getAssetsFromInvestorId(int investorID) async {
    return await _client.call(
      contract: _contract,
      function: _getAssetsByInvestorId,
      params: [BigInt.from(investorID)],
    );
  }

  getAssetsFromId(int assetId) async {
    return await _client.call(
      contract: _contract,
      function: _getAssetsById,
      params: [BigInt.from(assetId)],
    );
  }
}
