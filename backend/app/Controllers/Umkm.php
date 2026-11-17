<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class Umkm extends ResourceController
{
    protected $modelName = 'App\Models\UmkmModel';
    protected $format = 'json';

    public function index()
    {
        $data = $this->model->findAll();

        return $this->respond([
            'status' => 200,
            'message' => 'Data UMKM berhasil diambil',
            'data' => $data
        ]);
    }

    public function show($id = null)
    {
        $data = $this->model->find($id);

        if (!$data) {
            return $this->failNotFound('Data UMKM tidak ditemukan');
        }

        return $this->respond([
            'status' => 200,
            'message' => 'Data UMKM berhasil ditemukan',
            'data' => $data
        ]);
    }

    public function create()
    {
        $data = $this->request->getJSON(true);

        if (!$data) {
            return $this->failValidationErrors('Data JSON tidak valid');
        }

        $this->model->insert($data);

        return $this->respondCreated([
            'status' => 201,
            'message' => 'Data UMKM berhasil ditambahkan',
            'data' => $this->model->find($this->model->getInsertID())
        ]);
    }

    public function update($id = null)
    {
        $existing = $this->model->find($id);

        if (!$existing) {
            return $this->failNotFound('Data UMKM tidak ditemukan');
        }

        $input = $this->request->getJSON(true);

        if (!$input) {
            return $this->failValidationErrors('Data JSON tidak valid');
        }

        $this->model->update($id, $input);

        return $this->respond([
            'status' => 200,
            'message' => 'Data UMKM berhasil diperbarui',
            'data' => $this->model->find($id)
        ]);
    }

    public function delete($id = null)
    {
        $data = $this->model->find($id);

        if (!$data) {
            return $this->failNotFound('Data UMKM tidak ditemukan');
        }

        $this->model->delete($id);

        return $this->respondDeleted([
            'status' => 200,
            'message' => 'Data UMKM berhasil dihapus'
        ]);
    }
}
